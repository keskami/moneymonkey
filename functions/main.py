from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask, jsonify
import threading
import time
from statistics import mean
import random
from datetime import datetime, timedelta, timezone
from collections import deque



initialize_app()  
db = firestore.client()
app = Flask(__name__)

allStockVals = deque(maxlen=60)
allStockHourly = deque(maxlen=24)
allStockWeekly= deque(maxlen = 7)
allStockMonthly = deque(maxlen= 31)


BananaTechVals = deque(maxlen=60)
HealthyChimpVals = deque(maxlen=60)
EcoVineVals = deque(maxlen=60)
JungleGoodsVals = deque(maxlen=60)
BananaTechHourlyVals = deque(maxlen=24)
BananaTechWeeklyVals = deque(maxlen=7)
BananaTechMonthlyVals = deque(maxlen=31)
HealthyChimpHourlyVals = deque(maxlen=24)
HealthyChimpWeeklyVals = deque(maxlen=7)
HealthyChimpMonthlyVals = deque(maxlen=31)
EcoVineHourlyVals = deque(maxlen=24)
EcoVineWeeklyVals = deque(maxlen=7)
EcoVineMonthlyVals = deque(maxlen=31)
JungleGoodsHourlyVals = deque(maxlen=24)
JungleGoodsWeeklyVals = deque(maxlen=7)
JungleGoodsMonthlyVals = deque(maxlen=31)
currenthour = datetime.now().hour
stocksNowData = {}


def addHour():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimpHourlyVals, BananaTechHourlyVals, JungleGoodsHourlyVals, EcoVineHourlyVals, allStockHourly
    print("ADDING HOUR")

    if allStockVals:
        allStockHourly.append(round(mean(allStockVals),2))
    else:
        print("LLLLL")
    
    if HealthyChimpVals:
        HealthyChimpHourlyVals.append(round(mean(HealthyChimpVals), 2))
    else:
        print("HealthyChimpVals is empty.")
    
    if BananaTechVals:
        BananaTechHourlyVals.append(round(mean(BananaTechVals), 2))
    else:
        print("BananaTechVals is empty.")
    
    if EcoVineVals:
        EcoVineHourlyVals.append(round(mean(EcoVineVals), 2))
    else:
        print("EcoVineVals is empty.")
    
    if JungleGoodsVals:
        JungleGoodsHourlyVals.append(round(mean(JungleGoodsVals), 2))
    else:
        print("JungleGoodsVals is empty.")
    HealthyChimpVals = deque(list(HealthyChimpVals)[-2:])  
    BananaTechVals = deque(list(BananaTechVals)[-2:])
    EcoVineVals = deque(list(EcoVineVals)[-2:])
    JungleGoodsVals = deque(list(JungleGoodsVals)[-2:])
    print(f"HealthyChimp Hourly Values: {list(HealthyChimpHourlyVals)}")
    print(f"BananaTech Hourly Values: {list(BananaTechHourlyVals)}")
    print(f"EcoVine Hourly Values: {list(EcoVineHourlyVals)}")
    print(f"JungleGoods Hourly Values: {list(JungleGoodsHourlyVals)}")
    print(f"Allstock Hourly Values: {list(allStockHourly)}")
    return allStockVals, allStockHourly, EcoVineVals, EcoVineHourlyVals, BananaTechVals, BananaTechHourlyVals, JungleGoodsVals, JungleGoodsHourlyVals, HealthyChimpVals, HealthyChimpHourlyVals

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
        time.sleep(20)  



@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    global lastBanana, lastChimp, LastEconVine, LastJungle, stocksNowData
    global EcoVineVals, HealthyChimpVals, JungleGoodsVals, BananaTechVals, allStockVals
    global currenthour

    BananaTechValue = 124
    HealthyChimpValue = 64
    EcoVineValue = 80
    JungleGoodsValue = 55
    try:
        if len(HealthyChimpVals) >= 1 and len(BananaTechVals) >= 1 and len(EcoVineVals) >= 1 and len(JungleGoodsVals) >= 1:
            BananaTechVals.append(lastBanana)
            HealthyChimpVals.append(lastChimp)
            EcoVineVals.append(LastEconVine)
            JungleGoodsVals.append(LastJungle)
            BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
            HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
            EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
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
        
            BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
            HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
            EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
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
        BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
        HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
        EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
        JungleGoodsValue = round(pickValue(JungleGoodsVals, 'JungleGoods'), 2)
        print(e)

    
    lastBanana = BananaTechValue
    lastChimp = HealthyChimpValue
    LastEconVine = EcoVineValue
    LastJungle = JungleGoodsValue
    stocksNowData = {
        'BananaTechValue': BananaTechValue,
        'HealthyChimpValue': HealthyChimpValue,
        'EcoVineValue': EcoVineValue,
        'JungleGoodsValue': JungleGoodsValue,
        'Stocks': (BananaTechValue + HealthyChimpValue + EcoVineValue +JungleGoodsValue),
        'timestamp': datetime.now()
    }

    allStockVals.append(BananaTechValue + HealthyChimpValue + EcoVineValue +JungleGoodsValue)

    if currenthour != datetime.now().hour:
        allStockVals, allStockHourly, EcoVineVals, EcoVineHourlyVals, BananaTechVals, BananaTechHourlyVals, JungleGoodsVals, JungleGoodsHourlyVals, HealthyChimpVals, HealthyChimpHourlyVals = addHour()
        currenthour =  datetime.now().hour


    print("LENGTH", len(EcoVineVals))


    print(f"Updated stocks {stocksNowData}")
    return make_response("OK", 200)
    

    

'''@app.route('/get_stocks_now', methods=['GET'])
def get_stocks_now():
    print("HERERERERE", stocksNowData)
    return jsonify(stocksNowData),
   

    try:
        db.collection('BananaTech').add(bananaData)
        db.collection('HealthyChimp').add(chimpData)
        db.collection('EcoVine').add(ecoData)
        db.collection('JungleGoods').add(jungleData)
        db.collection('Stocks').add(stocksData)
        response = make_response("Document added to Firestore!", 200)
        return response
    except Exception as e:
        print(f"Error adding document: {e}") 
        response = make_response(f"Error adding document: {e}", 500)
        return response'''

threading.Thread(target=start, daemon=True).start()
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
#threading.Thread(target=consolidate_data, daemon=True).start()