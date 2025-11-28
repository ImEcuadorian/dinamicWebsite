<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sitio en Mantenimiento</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 600px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .maintenance-image {
            width: 100%;
            max-width: 400px;
            height: auto;
            margin: 30px 0;
            border-radius: 10px;
        }

        p {
            color: #666;
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .info p {
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .contact {
            color: #667eea;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2rem;
            }

            p {
                font-size: 1rem;
            }

            .container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="icon">🔧</div>
    <h1>Sitio en Mantenimiento</h1>

    <img src="https://via.placeholder.com/400x300/667eea/ffffff?text=En+Mantenimiento"
         alt="Página en mantenimiento"
         class="maintenance-image">

    <p>Estamos trabajando para mejorar nuestro sitio web y ofrecerle una mejor experiencia.</p>

    <p><strong>Disculpe las inconveniencias.</strong></p>

    <div class="info">
        <p>⏰ Estaremos de vuelta pronto</p>
        <p>📧 Si necesita asistencia urgente, contáctenos:</p>
        <p class="contact">info@ferreteria.com</p>
        <p class="contact">📞 (123) 456-7890</p>
    </div>
</div>
</body>
</html>