from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask
import threading
import time
from statistics import mean
import random
from datetime import datetime, timedelta
from collections import deque

#make it so data is not reread using dequee 




initialize_app()  
db = firestore.client()
app = Flask(__name__)
'''nextMinConsolidation = datetime.utcnow() + timedelta(minutes=1)
def consolidate_data(stock_names):

    for stock in stock_names:
        stock_ref = db.collection(stock).where('timestamp', '>=', one_hour_ago).get()
        values = [doc.to_dict().get('value') for doc in stock_ref if 'value' in doc.to_dict()]
        if values:
            avg_value = round(mean(values), 2)
            hourly_data = {
                'value': avg_value,
                'timestamp': firestore.SERVER_TIMESTAMP, 
            }
            db.collection(stock).add(hourly_data)
            for doc in stock_ref:
                db.collection(stock).document(doc.id).delete()'''

BananaTechVals = deque(maxlen=100)
HealthyChimpVals = deque(maxlen=100)
EcoVineVals = deque(maxlen=100)
JungleGoodsVals = deque(maxlen=100)
    

def pickValue(values, stock):
    if stock == 'BananaTech':
        return random.uniform(0.975, 1.03) * mean(values)
    elif stock == 'HealthyChimp':
        return random.uniform(0.985, 1.016) * mean(values) 
    elif stock == 'EcoVine':
        return random.uniform(0.97, 1.025) * mean(values) 
    elif stock == 'JungleGoods':
        return random.uniform(0.98, 1.02) * mean(values)

def start():
    while True:
        with app.app_context():  
            on_request_example(None)  
        time.sleep(5)  

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    global lastBanana, lastChimp, LastEconVine, LastJungle
    BananaTechValue = 124
    HealthyChimpValue = 64
    EcoVineValue = 80
    JungleGoodsValue = 55

    try:
        if len(HealthyChimpVals) >= 1 and len(BananaTechVals) >= 1 and len(EcoVineVals) >= 1 and len(JungleGoodsVals) >= 1:
            print("here")
            BananaTechVals.append(lastBanana)
            HealthyChimpVals.append(lastChimp)
            EcoVineVals.append(LastEconVine)
            JungleGoodsVals.append(LastJungle)
            if BananaTechVals:
                BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
            if HealthyChimpVals:
                HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
            if EcoVineVals:
                EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
            if JungleGoodsVals:
                JungleGoodsValue = round(pickValue(JungleGoodsVals, 'JungleGoods'), 2)

        else:
            print("WARNING READING")
            banana_ref = db.collection('BananaTech').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(1).get()
            chimp_ref = db.collection('HealthyChimp').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(1).get()
            ecovine_ref = db.collection('EcoVine').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(1).get()
            jungle_ref = db.collection('JungleGoods').order_by('timestamp', direction=firestore.Query.DESCENDING).limit(1).get()
            
            if banana_ref:
                for doc in banana_ref:
                    doc_data = doc.to_dict()
                    value = doc_data.get('value')
                    if value not in BananaTechVals:   
                        BananaTechVals.append(value)
                lastBanana = value
            if chimp_ref:
                for doc in chimp_ref:
                    doc_data = doc.to_dict()
                    value = doc_data.get('value')
                    if value not in HealthyChimpVals:
                        HealthyChimpVals.append(value)
                lastChimp = value
            if ecovine_ref:
                for doc in ecovine_ref:
                    doc_data = doc.to_dict()
                    value = doc_data.get('value')
                    if value not in EcoVineVals:
                        EcoVineVals.append(value)
                LastEconVine = value
            if jungle_ref:
                for doc in jungle_ref:
                    doc_data = doc.to_dict()
                    value = doc_data.get('value')
                    if value not in JungleGoodsVals:
                        JungleGoodsVals.append(doc_data.get('value'))
                LastJungle = value
        
            if BananaTechVals:
                BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
            if HealthyChimpVals:
                HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
                

            if EcoVineVals:
                EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
            if JungleGoodsVals:
                JungleGoodsValue = round(pickValue(JungleGoodsVals, 'JungleGoods'), 2)
    except Exception as e:
        BananaTechValue = 124
        BananaTechVals.append(BananaTechValue)
        lastBanana = BananaTechValue
        HealthyChimpValue = 64
        HealthyChimpVals.append(HealthyChimpValue)
        lastChimp = HealthyChimpValue
        EcoVineValue = 80
        EcoVineVals.append(EcoVineValue)
        LastEconVine = EcoVineValue
        JungleGoodsValue = 55
        JungleGoodsVals.append(JungleGoodsValue)
        LastJungle = JungleGoodsValue
        if BananaTechVals:
            BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
        if HealthyChimpVals:
            HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
        if EcoVineVals:
            EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
        if JungleGoodsVals:
            JungleGoodsValue = round(pickValue(JungleGoodsVals, 'JungleGoods'), 2)
        print(e)

    BananaTech_data_to_add = {
        'value': BananaTechValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    HealthyChimp_data_to_add = {
        'value': HealthyChimpValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }
    
    EcoVine_data_to_add = {
        'value': EcoVineValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    JungleGoods_data_to_add = {
        'value': JungleGoodsValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    stocksData = {
        'value': HealthyChimpValue + BananaTechValue + EcoVineValue + JungleGoodsValue,
        'timestamp': firestore.SERVER_TIMESTAMP
    }
    lastBanana = BananaTechValue
    lastChimp = HealthyChimpValue
    LastEconVine = EcoVineValue
    LastJungle = JungleGoodsValue
    print(f"Attempting to add data: {BananaTech_data_to_add}, {HealthyChimp_data_to_add}, {EcoVine_data_to_add}, {JungleGoods_data_to_add}, {stocksData}")

    try:
        db.collection('BananaTech').add(BananaTech_data_to_add)
        db.collection('HealthyChimp').add(HealthyChimp_data_to_add)
        db.collection('EcoVine').add(EcoVine_data_to_add)
        db.collection('JungleGoods').add(JungleGoods_data_to_add)
        db.collection('Stocks').add(stocksData)
        response = make_response("Document added to Firestore!", 200)
        return response
    except Exception as e:
        print(f"Error details: {e}") 
        response = make_response(f"Error adding document: {e}", 500)
        return response

threading.Thread(target=start, daemon=True).start()
