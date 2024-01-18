package controllers

import (
	"encoding/json"
	"log"

	"github.com/InnoFours/skin-savvy/mlModel"
	"github.com/gofiber/fiber/v2"
)

func SkinDetection(c *fiber.Ctx) error {
	image, err := c.FormFile("image")
	if err != nil {
		log.Fatal("Can't parse image", err.Error())
		return c.Status(fiber.StatusNotAcceptable).JSON(fiber.Map{
			"message": "Can't parse the image",
			"status":  fiber.StatusNotAcceptable,
			"error":   err.Error(),
		})
	}

	imageFile, err := image.Open()
	if err != nil {
		log.Fatal("Can't open image", err.Error())
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Can't open the image",
			"status":  fiber.StatusInternalServerError,
			"error":   err.Error(),
		})
	}

	predictions, err := mlModel.LoadModel(imageFile)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "cannot predict image",
			"status":  fiber.StatusInternalServerError,
			"error":   err.Error(),
		})
	}

	// Marshal predictions into JSON format
	jsonData, err := json.Marshal(predictions)
	if err != nil {
		log.Println("Error marshaling JSON:", err)
	}
	log.Println(string(jsonData))

	return c.JSON(fiber.Map{
		"message":     "Detection success",
		"status":      fiber.StatusOK,
		"predictions": predictions,
	})
}
