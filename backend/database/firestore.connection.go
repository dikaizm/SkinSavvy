package database

import (
	"context"
	"log"

	"github.com/InnoFours/skin-savvy/config"

	"cloud.google.com/go/firestore"
	"google.golang.org/api/option"
)

func FirestoreConnection() (*firestore.Client, error) {
	opt := option.WithCredentialsFile("/Users/dika-mac/Documents/PROGRAMMING/mobile-app/SkinSavvyAPI/service-account-key.json")
	client, err := firestore.NewClient(context.Background(), config.ConfigFirebaseProjectId(), opt)
	if err != nil {
		log.Println("error connecting to firestore", err.Error())
	}

	return client, nil
}
