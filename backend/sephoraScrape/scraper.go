package sephoraScrape

import (
	"context"
	"log"
	"regexp"
	"strings"
	"time"

	"github.com/InnoFours/skin-savvy/models/entity"
	"github.com/chromedp/cdproto/cdp"
	"github.com/chromedp/chromedp"
	"github.com/gofiber/fiber/v2"
)

func ProductScraper(geminiResponse []string) (*fiber.Map, error) {

	var listOfProduct []string
	for _, entry := range geminiResponse {
		parts := strings.SplitN(entry, ":", 2)
		if len(parts) != 2 {
			continue
		}

		skincareName := strings.TrimSpace(parts[0])
		listOfProduct = append(listOfProduct, skincareName)
	}

	options := append(
		chromedp.DefaultExecAllocatorOptions[:],
		chromedp.UserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"),
	)

	ctx, cancel := chromedp.NewExecAllocator(context.Background(), options...)
	defer cancel()

	ctx, cancel = chromedp.NewContext(ctx)
	defer cancel()

	var productDetailsMap []entity.ProductDetails

	i := 0
	log.Println("Scraping Process")
	for _, products := range listOfProduct {
		log.Println("Process", i)

		var productNodes []*cdp.Node

		log.Println("Process scrape link of product")
		err := chromedp.Run(ctx,
			chromedp.Navigate("https://www.sephora.com/search?keyword="+products),
			chromedp.Sleep(2000*time.Millisecond),
			chromedp.Nodes(".css-1322gsb .css-foh208 .css-h5rga0.eanm77i0:first-child > a", &productNodes, chromedp.ByQuery),
		)
		if err != nil {
			log.Fatal("Can't open website: ", err.Error())
		}

		var productLinks []string

		for _, node := range productNodes {
			href := node.AttributeValue("href")
			re := regexp.MustCompile(`\/product\/([^?]+)`)
			matches := re.FindStringSubmatch(href)
			if len(matches) > 1 {
				productLinks = append(productLinks, "https://www.sephora.com/"+matches[1])
			}
		}

		log.Println("Process scrape attribute of product")
		for _, link := range productLinks {
			var (
				Brand       string
				Name        string
				Price       string
				Quantity    string
				Explanation string
				ImageAttr   []map[string]string
			)

			for _, entry := range geminiResponse {
				if strings.Contains(entry, products) {
					parts := strings.SplitN(entry, ":", 2)
					if len(parts) == 2 {
						Explanation = strings.TrimSpace(parts[1])
						Explanation = strings.TrimLeft(Explanation, "*")
						break
					}
				}
			}

			err := chromedp.Run(ctx,
				chromedp.Navigate(link),
				chromedp.Sleep(2000*time.Millisecond),
				chromedp.Text(".css-1v7u6og.eanm77i0>div>h1>a", &Brand),
				chromedp.Text(".css-1v7u6og.eanm77i0>div>h1>span", &Name),
				chromedp.Text(".css-1v7u6og.eanm77i0>div>div>p>span>span>b", &Price),
				chromedp.Text(".css-1v7u6og.eanm77i0>div>.css-1jp3h9y>.css-k1zwuw>.css-1ag3xrp>.css-0>span", &Quantity),
				chromedp.AttributesAll(".css-1v7u6og.eanm77i0 > .css-v7bl16 > .css-1a2dflv.eanm77i0 > .css-wzxd08 > .css-3c349a > ul > li > .css-122y91a > .css-aaj5ah > button > picture > source", &ImageAttr),
			)
			if err != nil {
				log.Fatal("Error scraping information of the product: ", err.Error())
			}

			imageUrls := strings.Split(ImageAttr[0]["srcset"], ",")[0]
			imageUrl := imageUrls[:len(imageUrls)-3] + "0"

			productDetails := entity.ProductDetails{
				Brand:       Brand,
				Name:        Name,
				Price:       Price,
				URL:         link,
				ImageURL:    imageUrl,
				Quantity:    Quantity,
				Explanation: Explanation,
			}

			productDetailsMap = append(productDetailsMap, productDetails)

			log.Println("Product Brand:", Brand)
			log.Println("Product Name:", Name)
			log.Println("Product Price:", Price)
			log.Println("Product Quantity:", Quantity)
			log.Println("Product Link:", link)
			log.Println("Product Image:", imageUrl)
			log.Println("Explanation:", Explanation)
			log.Println("========================================================================================================")
		}
		i++
	}

	return &fiber.Map{"product_details": productDetailsMap}, nil
}
