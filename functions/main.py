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
allStock5MinsforDay = deque(maxlen=288)
allStock30for5= deque(maxlen = 240)
allStock31days= deque(maxlen= 31)
allStock365days = deque(maxlen=365)


BananaTechVals = deque(maxlen=60)
BananaTech5MinsforDay = deque(maxlen=288)
BananaTech30for5 = deque(maxlen=240)
BananaTech31days = deque(maxlen=31)
BananaTech365days = deque(maxlen =365)


HealthyChimpVals = deque(maxlen=60)
HealthyChimp5MinsforDay = deque(maxlen=289)
HealthyChimp30for5 = deque(maxlen=240)
HealthyChimp31days = deque(maxlen=31)
HealthyChimp365days = deque(maxlen=365)



EcoVineVals = deque(maxlen=60)
EcoVine5MinsforDay = deque(maxlen=289)
EcoVine30for5 = deque(maxlen=240)
EcoVine31days = deque(maxlen=31)
EcoVine365days = deque(maxlen=365)

JungleGoodsVals = deque(maxlen=60)
JungleGoods5MinsforDay = deque(maxlen=289)
JungleGoods30for5 = deque(maxlen=240)
JungleGoods31days = deque(maxlen=31)
JungleGoods365days = deque(maxlen=365)




currenthour = datetime.now().hour
currentminute = datetime.now().minute
currentminute5 = (currentminute // 5) * 5
currentminute30 = (currentminute // 30) * 30
currentDate = datetime.now().date()
stocksNowData = {}


def newDay():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimp31days, HealthyChimp365days, BananaTech31days, BananaTech365days
    global JungleGoods31days, JungleGoods365days, EcoVine31days, EcoVine365days
    global allStock31days, allStock365days, allStock30for5, EcoVine30for5
    global BananaTech30for5, JungleGoods30for5, HealthyChimp30for5
    global allStock5MinsforDay, EcoVine5MinsforDay, BananaTech5MinsforDay
    global JungleGoods5MinsforDay, HealthyChimp5MinsforDay
    print("New Day")
    def updateForDay(stockVals, stock31, stock365, stock5forday):
        if stockVals:
            stock31.append(round(mean(list(stock5forday)), 2))
            stock365.append(round(mean(list(stock5forday)), 2))
            stock5forday = list(stock5forday)[-1:]
        return stock31, stock365, stock5forday

    allStock31days, allStock365days, allStock5MinsforDay = updateForDay(allStockVals, allStock31days, allStock365days, allStock5MinsforDay)
    HealthyChimp31days, HealthyChimp365days, HealthyChimp5MinsforDay = updateForDay(HealthyChimpVals, HealthyChimp31days, HealthyChimp365days, HealthyChimp5MinsforDay)
    BananaTech31days, BananaTech365days, BananaTech5MinsforDay = updateForDay(BananaTechVals, BananaTech31days, BananaTech365days, BananaTech5MinsforDay)
    JungleGoods31days, JungleGoods365days, JungleGoods5MinsforDay = updateForDay(JungleGoodsVals, JungleGoods31days, JungleGoods365days, JungleGoods5MinsforDay)
    EcoVine31days, EcoVine365days, EcoVine5MinsforDay = updateForDay(EcoVineVals, EcoVine31days, EcoVine365days, EcoVine5MinsforDay)


def add30mins():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimp30for5, BananaTech30for5, JungleGoods30for5, EcoVine30for5, allStock30for5
    print("Adding 30")
    if allStockVals:
        allStock30for5.append(round(mean(list(allStockVals)[-30:]), 2))
    else:
        print("allStockVals is empty.")
    
    if HealthyChimpVals:
        HealthyChimp30for5.append(round(mean(list(HealthyChimpVals)[-30:]), 2))
    else:
        print("HealthyChimpVals is empty.")
    
    if BananaTechVals:
        BananaTech30for5.append(round(mean(list(BananaTechVals)[-30:]), 2))
    else:
        print("BananaTechVals is empty.")
    
    if EcoVineVals:
        EcoVine30for5.append(round(mean(list(EcoVineVals)[-30:]), 2))
    else:
        print("EcoVineVals is empty.")
    
    if JungleGoodsVals:
        JungleGoods30for5.append(round(mean(list(JungleGoodsVals)[-30:]), 2))
    else:
        print("JungleGoodsVals is empty.")
    
    print(f"HealthyChimp30min Vals: {list(HealthyChimp30for5)}")
    print(f"BananaTech30min Vals: {list(BananaTech30for5)}")
    print(f"EcoVine30min Vals: {list(EcoVine30for5)}")
    print(f"JungleGoods30min Vals: {list(JungleGoods30for5)}")
    print(f"Allstock30min Vals: {list(allStock30for5)}")
    
    return allStockVals, allStock30for5, EcoVineVals, EcoVine30for5, BananaTechVals, BananaTech30for5, JungleGoodsVals, JungleGoods30for5, HealthyChimpVals, HealthyChimp30for5

    

def add5min():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimp5MinsforDay, BananaTech5MinsforDay, JungleGoods5MinsforDay, EcoVine5MinsforDay, allStock5MinsforDay
    print("ADDING 5 minutes")

    if allStockVals:
        allStock5MinsforDay.append(round(mean(list(allStockVals)[-5:]),2))
    else:
        print("LLLLL")
    
    if HealthyChimpVals:
        HealthyChimp5MinsforDay.append(round(mean(list(HealthyChimpVals)[-5:]), 2))
    else:
        print("HealthyChimpVals is empty.")
    
    if BananaTechVals:
        BananaTech5MinsforDay.append(round(mean(list(BananaTechVals)[-5:]), 2))
    else:
        print("BananaTechVals is empty.")
    
    if EcoVineVals:
        EcoVine5MinsforDay.append(round(mean(list(EcoVineVals)[-5:]), 2))
    else:
        print("EcoVineVals is empty.")
    
    if JungleGoodsVals:
        JungleGoods5MinsforDay.append(round(mean(list(JungleGoodsVals)[-5:]), 2))
    else:
        print("JungleGoodsVals is empty.")
    print(f"HealthyChimp5min Vals: {list(HealthyChimp5MinsforDay)}")
    print(f"BananaTech5min Vals: {list(BananaTech5MinsforDay)}")
    print(f"EcoVine5min Vals: {list(EcoVine5MinsforDay)}")
    print(f"JungleGoods5min Vals: {list(JungleGoods5MinsforDay)}")
    print(f"Allstock5min Vals: {list(allStock5MinsforDay)}")
    return allStockVals, allStock5MinsforDay, EcoVineVals, EcoVine5MinsforDay, BananaTechVals, BananaTech5MinsforDay, JungleGoodsVals, JungleGoods5MinsforDay, HealthyChimpVals, HealthyChimp5MinsforDay

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
    global currenthour, currentminute, currentminute5, currentminute30, currentDate
    global EcoVine5MinsforDay, EcoVine30for5

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

    if currentminute5 == 60:
        if datetime.now().minute == 60 or datetime.now().minute < 10:  
            currentminute5 = 5
            allStockVals, allStock5MinsforDay, EcoVineVals, EcoVine5MinsforDay, BananaTechVals, BananaTech5MinsforDay, JungleGoodsVals, JungleGoods5MinsforDay, HealthyChimpVals, HealthyChimp5MinsforDay  = add5min() 
    elif currentminute5 + 5 <= datetime.now().minute:
        currentminute5 += 5
        allStockVals, allStock5MinsforDay, EcoVineVals, EcoVine5MinsforDay, BananaTechVals, BananaTech5MinsforDay, JungleGoodsVals, JungleGoods5MinsforDay, HealthyChimpVals, HealthyChimp5MinsforDay  = add5min() 
    
    if currentminute30 == 60:
        if datetime.now().minute < 60:
            currentminute30 = 30
            allStockVals, allStock30for5, EcoVineVals, EcoVine30for5, BananaTechVals, BananaTech30for5, JungleGoodsVals, JungleGoods30for5, HealthyChimpVals, HealthyChimp30for5 = add30mins()
    elif currentminute30 + 30 <= datetime.now().minute:
        currentminute30 += 30
        allStockVals, allStock30for5, EcoVineVals, EcoVine30for5, BananaTechVals, BananaTech30for5, JungleGoodsVals, JungleGoods30for5, HealthyChimpVals, HealthyChimp30for5 = add30mins()

    if currentDate < datetime.now().date() and datetime.now().hour >= 9 and datetime.now().minute >= 30:
        currentDate = datetime.now().date()
        newDay()

    


    print(EcoVineVals)
    print(EcoVine5MinsforDay)
    print(EcoVine30for5)



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