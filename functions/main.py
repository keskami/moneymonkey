from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask
import threading
import time
from statistics import mean
import random




initialize_app()  
db = firestore.client()
app = Flask(__name__)

def pickValue(values):
    return random.uniform(0.95, 1.05) * mean(values)

#this is what starts the market when on_request_example is called
def start():
    while True:
        with app.app_context():  
            on_request_example(None)  
        time.sleep(10)  

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    value = 100
    try:
        vals = []
        doc_ref = db.collection('TestAdding').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(30).get()
        if doc_ref:
            for doc in doc_ref:
                doc_data = doc.to_dict()   
                vals.append(doc_data.get('value')) 
        value = round(pickValue(vals),2)
        
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
        print(f"Error details: {e}") 
        response = make_response(f"Error adding document: {e}", 500)
        return response

# Start the periodic thread
threading.Thread(target=start, daemon=True).start()
