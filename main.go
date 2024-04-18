package main

import (
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"
)

func main() {
	r := gin.Default()

	// Configuração do CORS para permitir qualquer origem
	config := cors.DefaultConfig()
	config.AllowAllOrigins = true

	r.Use(cors.New(config))

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.Run() // escuta e serve na porta 0.0.0.0:8080
}
