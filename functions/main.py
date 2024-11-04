from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask
import threading
import time

# Initialize the Firebase Admin SDK
initialize_app()  # Ensure your project is correctly set up in Firebase

# Create a Firestore client
db = firestore.client()

# Create a Flask application
app = Flask(__name__)

def periodic_run():
    while True:
        with app.app_context():  
            on_request_example(None)  
        time.sleep(10)  

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    value = 100
    try:
        doc_ref = db.collection('TestAdding').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(1).get()
        if doc_ref:
            for doc in doc_ref:
                doc_data = doc.to_dict()  
                value = doc_data.get('value') + 1  
                print(f"Retrieved document value: {value},")
    except Exception as e:
        print(e)

    data_to_add = {
        'value': value,
        'timestamp': firestore.SERVER_TIMESTAMP
    }
    print(f"Attempting to add data: {data_to_add}")
    try:
        # Add data to Firestore
        db.collection('TestAdding').add(data_to_add)
        response = make_response("Document added to Firestore!", 200)
        return response
    except Exception as e:
        print(f"Error details: {e}")  # Log the error for debugging
        response = make_response(f"Error adding document: {e}", 500)
        return response

# Start the periodic thread
threading.Thread(target=periodic_run, daemon=True).start()
