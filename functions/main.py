from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask, jsonify
import threading
import time
from statistics import mean
import random
from datetime import datetime, timedelta, timezone
from collections import deque
cst = timezone(timedelta(hours=-6))

initialize_app()  
db = firestore.client()
app = Flask(__name__)
#stocks
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



#ETFS
# TechTree ETF
TechTreeVals = deque(maxlen=60)
TechTree5MinsforDay = deque(maxlen=288)
TechTree30for5 = deque(maxlen=240)
TechTree31days = deque(maxlen=31)
TechTree365days = deque(maxlen=365)

# MonkeyMed ETF
MonkeyMedVals = deque(maxlen=60)
MonkeyMed5MinsforDay = deque(maxlen=288)
MonkeyMed30for5 = deque(maxlen=240)
MonkeyMed31days = deque(maxlen=31)
MonkeyMed365days = deque(maxlen=365)

# GreenLeaf Power ETF
GreenLeafVals = deque(maxlen=60)
GreenLeaf5MinsforDay = deque(maxlen=288)
GreenLeaf30for5 = deque(maxlen=240)
GreenLeaf31days = deque(maxlen=31)
GreenLeaf365days = deque(maxlen=365)

# Gorilla Goods ETF
GorillaGoodsVals = deque(maxlen=60)
GorillaGoods5MinsforDay = deque(maxlen=288)
GorillaGoods30for5 = deque(maxlen=240)
GorillaGoods31days = deque(maxlen=31)
GorillaGoods365days = deque(maxlen=365)

allETFVals = deque(maxlen=60)
allETFS5MinsforDay = deque(maxlen=288)
allETFS30for5= deque(maxlen = 240)
allETFS31days= deque(maxlen= 31)
allETFS365days = deque(maxlen=365)





currenthour = datetime.now(cst).hour
currentminute = datetime.now(cst).minute
currentminute5 = (currentminute // 5) * 5
currentminute30 = (currentminute // 30) * 30
currentDate = datetime.now(cst).date()

print(datetime.now(cst))
stocksNowData = {}
etfsNowData = {}


def newDay():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimp31days, HealthyChimp365days, BananaTech31days, BananaTech365days
    global JungleGoods31days, JungleGoods365days, EcoVine31days, EcoVine365days
    global allStock31days, allStock365days, allStock30for5, EcoVine30for5
    global BananaTech30for5, JungleGoods30for5, HealthyChimp30for5
    global allStock5MinsforDay, EcoVine5MinsforDay, BananaTech5MinsforDay
    global JungleGoods5MinsforDay, HealthyChimp5MinsforDay
    global TechTreeVals, TechTree5MinsforDay, TechTree30for5, TechTree31days, TechTree365days
    global MonkeyMedVals, MonkeyMed5MinsforDay, MonkeyMed30for5, MonkeyMed31days, MonkeyMed365days
    global GreenLeafVals, GreenLeaf5MinsforDay, GreenLeaf30for5, GreenLeaf31days, GreenLeaf365days
    global GorillaGoodsVals, GorillaGoods5MinsforDay, GorillaGoods30for5, GorillaGoods31days, GorillaGoods365days
    global allETFVals, allETFS31days, allETFS365days, allETFS5MinsforDay


    print("New Day")
    def updateForDay(stockVals, stock31, stock365, stock5forday):
        if stockVals:
            stock31.append(round(mean(list(stock5forday)), 2))
            stock365.append(round(mean(list(stock5forday)), 2))
            stock5forday = deque(list(stock5forday)[-1:], maxlen=stock5forday.maxlen)
        return stock31, stock365, stock5forday

    allStock31days, allStock365days, allStock5MinsforDay = updateForDay(allStockVals, allStock31days, allStock365days, allStock5MinsforDay)
    HealthyChimp31days, HealthyChimp365days, HealthyChimp5MinsforDay = updateForDay(HealthyChimpVals, HealthyChimp31days, HealthyChimp365days, HealthyChimp5MinsforDay)
    BananaTech31days, BananaTech365days, BananaTech5MinsforDay = updateForDay(BananaTechVals, BananaTech31days, BananaTech365days, BananaTech5MinsforDay)
    JungleGoods31days, JungleGoods365days, JungleGoods5MinsforDay = updateForDay(JungleGoodsVals, JungleGoods31days, JungleGoods365days, JungleGoods5MinsforDay)
    EcoVine31days, EcoVine365days, EcoVine5MinsforDay = updateForDay(EcoVineVals, EcoVine31days, EcoVine365days, EcoVine5MinsforDay)

    allETFS31days, allETFS365days, allETFS5MinsforDay, = updateForDay(allETFVals, allETFS31days, allETFS365days, allETFS5MinsforDay)
    TechTree31days, TechTree365days, TechTree5MinsforDay = updateForDay(TechTreeVals, TechTree31days, TechTree365days, TechTree5MinsforDay)
    MonkeyMed31days, MonkeyMed365days, MonkeyMed5MinsforDay = updateForDay(MonkeyMedVals, MonkeyMed31days, MonkeyMed365days, MonkeyMed5MinsforDay)
    GreenLeaf31days, GreenLeaf365days, GreenLeaf5MinsforDay = updateForDay(GreenLeafVals, GreenLeaf31days, GreenLeaf365days, GreenLeaf5MinsforDay)
    GorillaGoods31days, GorillaGoods365days, GorillaGoods5MinsforDay = updateForDay(GorillaGoodsVals, GorillaGoods31days, GorillaGoods365days, GorillaGoods5MinsforDay)


    


def add30mins():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimp30for5, BananaTech30for5, JungleGoods30for5, EcoVine30for5, allStock30for5
    global TechTreeVals, MonkeyMedVals, GreenLeafVals, GorillaGoodsVals, allETFVals
    global TechTree30for5, MonkeyMed30for5, GreenLeaf30for5, GorillaGoods30for5, allETFS30for5
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
    
    if TechTreeVals:
        TechTree30for5.append(round(mean(list(TechTreeVals)[-30:]), 2))
    else:
        print("TechTreeVals is empty.")
    
    if MonkeyMedVals:
        MonkeyMed30for5.append(round(mean(list(MonkeyMedVals)[-30:]), 2))
    else:
        print("MonkeyMedVals is empty.")
    
    if GreenLeafVals:
        GreenLeaf30for5.append(round(mean(list(GreenLeafVals)[-30:]), 2))
    else:
        print("GreenLeafVals is empty.")
    
    if GorillaGoodsVals:
        GorillaGoods30for5.append(round(mean(list(GorillaGoodsVals)[-30:]), 2))
    else:
        print("GorillaGoodsVals is empty.")
    
    if allETFVals:
        allETFS30for5.append(round(mean(list(allETFVals)[-30:]), 2))
    else:
        print("allETFVals is empty.")
    
    print(f"HealthyChimp30min Vals: {list(HealthyChimp30for5)}")
    print(f"BananaTech30min Vals: {list(BananaTech30for5)}")
    print(f"EcoVine30min Vals: {list(EcoVine30for5)}")
    print(f"JungleGoods30min Vals: {list(JungleGoods30for5)}")
    print(f"Allstock30min Vals: {list(allStock30for5)}")
    print(f"TechTree30min Vals: {list(TechTree30for5)}")
    print(f"MonkeyMed30min Vals: {list(MonkeyMed30for5)}")
    print(f"GreenLeaf30min Vals: {list(GreenLeaf30for5)}")
    print(f"GorillaGoods30min Vals: {list(GorillaGoods30for5)}")
    print(f"AllETFS30min Vals: {list(allETFS30for5)}")


    

def add5min():
    global HealthyChimpVals, BananaTechVals, EcoVineVals, JungleGoodsVals, allStockVals
    global HealthyChimp5MinsforDay, BananaTech5MinsforDay, JungleGoods5MinsforDay, EcoVine5MinsforDay, allStock5MinsforDay
    global TechTreeVals, MonkeyMedVals, GreenLeafVals, GorillaGoodsVals, allETFVals
    global TechTree5MinsforDay, MonkeyMed5MinsforDay, GreenLeaf5MinsforDay, GorillaGoods5MinsforDay, allETFS5MinsforDay
    print("ADDING 5 minutes")
    if allStockVals:
        allStock5MinsforDay.append(round(mean(list(allStockVals)[-5:]), 2))
    else:
        print("allStockVals is empty.")
    

    if HealthyChimpVals:
        HealthyChimp5MinsforDay.append(round(mean(list(HealthyChimpVals)[-5:]), 2))
    else:
        print("HealthyChimpVals is empty.")
    
    # Process BananaTech values
    if BananaTechVals:
        BananaTech5MinsforDay.append(round(mean(list(BananaTechVals)[-5:]), 2))
    else:
        print("BananaTechVals is empty.")
    
    # Process EcoVine values
    if EcoVineVals:
        EcoVine5MinsforDay.append(round(mean(list(EcoVineVals)[-5:]), 2))
    else:
        print("EcoVineVals is empty.")
    
    # Process JungleGoods values
    if JungleGoodsVals:
        JungleGoods5MinsforDay.append(round(mean(list(JungleGoodsVals)[-5:]), 2))
    else:
        print("JungleGoodsVals is empty.")
    
    # Process TechTree ETF values
    if TechTreeVals:
        TechTree5MinsforDay.append(round(mean(list(TechTreeVals)[-5:]), 2))
    else:
        print("TechTreeVals is empty.")
    
    # Process MonkeyMed ETF values
    if MonkeyMedVals:
        MonkeyMed5MinsforDay.append(round(mean(list(MonkeyMedVals)[-5:]), 2))
    else:
        print("MonkeyMedVals is empty.")
    
    # Process GreenLeaf ETF values
    if GreenLeafVals:
        GreenLeaf5MinsforDay.append(round(mean(list(GreenLeafVals)[-5:]), 2))
    else:
        print("GreenLeafVals is empty.")

    if GorillaGoodsVals:
        GorillaGoods5MinsforDay.append(round(mean(list(GorillaGoodsVals)[-5:]), 2))
    else:
        print("GorillaGoodsVals is empty.")

    if allETFVals:
        allETFS5MinsforDay.append(round(mean(list(allETFVals)[-5:]), 2))
    else:
        print("allETFVals is empty.")
   

def pickValue(values, stock):
    if stock == 'BananaTech':
        return random.uniform(0.975, 1.03) * mean(values)
    elif stock == 'HealthyChimp':
        return random.uniform(0.985, 1.016) * mean(values) 
    elif stock == 'EcoVine':
        return random.uniform(0.97, 1.025) * mean(values) 
    elif stock == 'JungleGoods':
        return random.uniform(0.98, 1.02) * mean(values)
    elif stock == "TreeTech":
         return random.uniform(0.99, 1.11) * mean(values)
    elif stock == "MonkeyMed":
         return random.uniform(0.992, 1.085) * mean(values)
    elif stock == "GreenLeaf":
         return random.uniform(0.983, 1.20) * mean(values)
    elif stock == "GorillaGoods":
         return random.uniform(0.983, 1.17) * mean(values)

         




def start():
    while True:
        with app.app_context():  
            on_request_example(None)  
        time.sleep(20) 

def updateStocks():
    global lastBanana, lastChimp, LastEconVine, LastJungle, stocksNowData, etfsNowData
    global lastTreeTech, lastMonkeyMed, lastGreenLeaf, lastGorillaGoods
    global EcoVineVals, HealthyChimpVals, JungleGoodsVals, BananaTechVals, allStockVals
    global TechTreeVals, MonkeyMedVals, GreenLeafVals, GorillaGoodsVals, allETFVals
    global currenthour, currentminute, currentminute5, currentminute30, currentDate
    global EcoVine5MinsforDay, EcoVine30for5, EcoVine31days

    while True:
        time.sleep(59.9)

        BananaTechValue = 124
        HealthyChimpValue = 64
        EcoVineValue = 80
        JungleGoodsValue = 55

        TreeTechValue = 87
        MonkeyMedValue = 109
        GreenLeafValue = 187
        GorillaGoodsValue = 208




        try:
            if len(HealthyChimpVals) >= 1 and len(BananaTechVals) >= 1 and len(EcoVineVals) >= 1 and len(JungleGoodsVals) >= 1 and len(TechTreeVals) >= 1 and len(MonkeyMedVals) >= 1 and len(GreenLeafVals) >= 1 and len(GorillaGoodsVals) >= 1:
                BananaTechVals.append(lastBanana)
                HealthyChimpVals.append(lastChimp)
                EcoVineVals.append(LastEconVine)
                JungleGoodsVals.append(LastJungle)

                TechTreeVals.append(LastJungle)
                MonkeyMedVals.append(lastMonkeyMed)
                GreenLeafVals.append(lastGreenLeaf)
                GorillaGoodsVals.append(lastGorillaGoods)
                
                BananaTechValue = round(pickValue(BananaTechVals, 'BananaTech'), 2)
                HealthyChimpValue = round(pickValue(HealthyChimpVals, 'HealthyChimp'), 2)
                EcoVineValue = round(pickValue(EcoVineVals, 'EcoVine'), 2)
                JungleGoodsValue = round(pickValue(JungleGoodsVals, 'JungleGoods'), 2)

                TreeTechValue = round(pickValue(TechTreeVals, 'TreeTech'), 2)
                MonkeyMedValue = round(pickValue(MonkeyMedVals, 'MonkeyMed'), 2)
                GreenLeafValue = round(pickValue(GreenLeafVals, 'GreenLeaf'), 2)
                GorillaGoodsValue = round(pickValue(GorillaGoodsVals, 'BananaTech'), 2)


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

                lastTreeTech = 87
                TechTreeVals.append(87)
                TreeTechValue = 87
                lastMonkeyMed = 109
                MonkeyMedVals.append(109)
                MonkeyMedValue = 109
                lastGreenLeaf = 187
                GreenLeafVals.append(187)
                GreenLeafValue = 187
                GorillaGoodsValue = 208
                lastGorillaGoods= 208
                GorillaGoodsVals.append(208)


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
            lastTreeTech = 87
            TechTreeVals.append(87)
            TreeTechValue = 87
            lastMonkeyMed = 109
            MonkeyMedVals.append(109)
            MonkeyMedValue = 109
            lastGreenLeaf = 187
            GreenLeafVals.append(187)
            GreenLeafValue = 187
            GorillaGoodsValue = 208
            lastGorillaGoods= 208
            GorillaGoodsVals.append(208)
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
            'timestamp': datetime.now(cst)
        }
        allStockVals.append(BananaTechValue + HealthyChimpValue + EcoVineValue +JungleGoodsValue)

        lastTreeTech = TreeTechValue
        lastMonkeyMed = MonkeyMedValue
        lastGreenLeaf = GreenLeafValue
        lastGorillaGoods = GorillaGoodsValue

        etfVal = TreeTechValue + MonkeyMedValue + GreenLeafValue + GorillaGoodsValue
        allETFVals.append(etfVal)
    

        etfsNowData = {
            "TreeTechValue" : TreeTechValue,
            "MonkeyMedValue": MonkeyMedValue,
            "GreenLeafValue": GreenLeafValue,
            "GorillaGoodsValue": GorillaGoodsValue,
            "timestamp": datetime.now(cst)
        }

        if currentminute5 == 60:
            if datetime.now(cst).minute == 60 or datetime.now(cst).minute < 10:  
                currentminute5 = 5
                add5min() 
        elif currentminute5 + 5 <= datetime.now(cst).minute:
            currentminute5 += 5
            add5min() 
        
        if currentminute30 == 60:
            if datetime.now(cst).minute < 60:
                currentminute30 = 30
                add30mins()
        elif currentminute30 + 30 <= datetime.now(cst).minute:
            currentminute30 += 30
            add30mins()

        if currentDate < datetime.now(cst).date() and datetime.now(cst).hour >= 9 and datetime.now(cst).minute >= 30:
            currentDate = datetime.now(cst).date()
            newDay()

        


        print(EcoVineVals)
        print(EcoVine5MinsforDay)
        print(EcoVine30for5)
        print(EcoVine31days)



        print(f"Updated stocks {stocksNowData}")
        print(f"Updated ETFs {etfsNowData}")


def start_background_tasks():
    update_thread = threading.Thread(target=updateStocks, daemon=True)
    update_thread.start()



@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    path = req.path  # Get the requested path (i.e., /api/stocks or /api/etfs)
    
    if req.method == 'GET':
        # Check if the path matches the stocks or etfs route
        if path == '/api/stocks':
            return jsonify(stocksNowData)
        elif path == '/api/etfs':
            return jsonify(etfsNowData)
        else:
            return make_response("Not Found", 404)
    return make_response("OK", 200)

start_background_tasks()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)



    

'''
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
