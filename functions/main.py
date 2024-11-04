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

def pickValue(values, stock):
    if stock == 'BananaTech':
        return random.uniform(0.975, 1.03) * mean(values)
    elif stock == 'HealthyChimp':
        return random.uniform(0.985, 1.016) * mean(values)

def start():
    while True:
        with app.app_context():  
            on_request_example(None)  
        time.sleep(10)  

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    BananaTechValue = 0
    HealthyChimpValue = 0
    try:
        BananaTechVals = []
        HealthyChimpVals = []
        banana_ref = db.collection('BananaTech').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(30).get()
        chimp_ref = db.collection('HealthyChimp').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(30).get()
        if banana_ref:
            for doc in banana_ref:
                doc_data = doc.to_dict()   
                BananaTechVals.append(doc_data.get('value')) 
        if chimp_ref:
            for doc in chimp_ref:
                doc_data = doc.to_dict() 
                HealthyChimpVals.append(doc_data.get('value'))
        
        HealthyChimpValue
        if BananaTechVals:
            BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
        if HealthyChimpVals:
            HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
    except Exception as e:
        BananaTechValue = 124
        HealthyChimpValue = 64
        print(e)

    BananaTech_data_to_add = {
        'value': BananaTechValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    HealthyChimp_data_to_add = {
        'value': HealthyChimpValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    stocksData = {
        'value': HealthyChimpValue + BananaTechValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }


    print(f"Attempting to add data: {BananaTech_data_to_add}")
    try:
        db.collection('BananaTech').add(BananaTech_data_to_add)
        db.collection('HealthyChimp').add(HealthyChimp_data_to_add)
        db.collection('Stocks').add(stocksData)
        response = make_response("Document added to Firestore!", 200)
        return response
    except Exception as e:
        print(f"Error details: {e}") 
        response = make_response(f"Error adding document: {e}", 500)
        return response

threading.Thread(target=start, daemon=True).start()
