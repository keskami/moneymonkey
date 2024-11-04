from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask
import threading
import time

# Initialize the Firebase Admin SDK
initialize_app()

# Create a Firestore client
db = firestore.client()

# Create a Flask application
app = Flask(__name__)

def periodic_run():
    while True:
        data_to_add = {
        'name': 'Example Name',
        'value': 'Example Value',
        'timestamp': firestore.SERVER_TIMESTAMP
    }
        with app.app_context():  
            on_request_example(None)  
        time.sleep(10)  

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
   
    data_to_add = {
        'value': 100,
        'timestamp': firestore.SERVER_TIMESTAMP
    }
    
    
    try:
        db.collection('myCollection').add(data_to_add)
        response = make_response("Document added to Firestore!", 200)
        return response
    except Exception as e:
        response = make_response(f"Error adding document: {e}", 500)
        return response

threading.Thread(target=periodic_run, daemon=True).start()
