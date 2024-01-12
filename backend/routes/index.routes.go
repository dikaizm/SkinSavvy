package routes

import (
	"github.com/gofiber/fiber/v2"

	"github.com/InnoFours/skin-savvy/auth"
	"github.com/InnoFours/skin-savvy/controllers"
)

func SetupEndpoint(r *fiber.App, authService *auth.AuthService) {

	authController := controllers.NewAuthController(authService)

	r.Get("/", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"message": "Welcome to SkinSavvy Beta Version 1.0 Public API👍",
			"status": fiber.StatusOK,
		})
	})

	//user endpoint
	//public endpoint
	r.Post("/skinsavvy-api/v0.1/post/user/register", authController.UserRegister) //endpoint for user account register
	r.Post("/skinsavvy-api/v0.1/post/user/login", authController.Login) //endpoint for user account login
	r.Post("/skinsavvy-api/v0.1/post/predict", controllers.SkinDetection)
	r.Post("/skinsavvy-api/v0.1/post/recommendation", controllers.SkincareRec)

	// //protected method
	// protected := r.Group("skinsavvy-api/v0.1/protected")
	// protected.Use(middleware.TokenValidator)

	// //protected endpoint for use controller
	// protected.Get("/get/user", userAuthController.GetAllUser) //endpoint to get all user data
	// protected.Get("get/user/:id", userController.GetOneUserAccount) //endpoint to get one user data by objectid
	// protected.Put("put/user/update/:id", userController.UpdateUserInfo) //endpoint for update user data information by objectcid
	// protected.Delete("delete/user/remove/:id", userController.DeleteUserAccount) //endpoint to remove user data by objectid
}