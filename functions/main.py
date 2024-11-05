from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore
from flask import make_response, Flask
import threading
import time
from statistics import mean
import random
from datetime import datetime, timedelta, timezone
from collections import deque

initialize_app()  
db = firestore.client()
app = Flask(__name__)

BananaTechVals = deque(maxlen=60)
HealthyChimpVals = deque(maxlen=60)
EcoVineVals = deque(maxlen=60)
JungleGoodsVals = deque(maxlen=60)



BananaTechDailyVals = deque(maxlen=24)
BananaTechWeeklyVals = deque(maxlen=7)
BananaTechMonthlyVals = deque(maxlen=31)


HealthyChimpDailyVals = deque(maxlen=24)
HealthyChimpWeeklyVals = deque(maxlen=7)
HealthyChimpMonthlyVals = deque(maxlen=31)


EcoVineDailyVals = deque(maxlen=24)
EcoVineWeeklyVals = deque(maxlen=7)
EcoVineMonthlyVals = deque(maxlen=31)


JungleGoodsDailyVals = deque(maxlen=24)
JungleGoodsWeeklyVals = deque(maxlen=7)
JungleGoodsMonthlyVals = deque(maxlen=31)

hours_passed = 0
days_passed = 0




def pickValue(values, stock):
    if stock == 'BananaTech':
        return random.uniform(0.975, 1.03) * mean(values)
    elif stock == 'HealthyChimp':
        return random.uniform(0.985, 1.016) * mean(values) 
    elif stock == 'EcoVine':
        return random.uniform(0.97, 1.025) * mean(values) 
    elif stock == 'JungleGoods':
        return random.uniform(0.98, 1.02) * mean(values)

def consolidate_data():
    global hours_passed
    global days_passed
    print("CONSOLODATING")
    now = datetime.now(timezone.utc)
    hourly_timestamp = now.replace(minute=0, second=0, microsecond=0)
    daily_timestamp = now.replace(hour=0, minute=0, second=0, microsecond=0)
    weekly_timestamp = now.replace(day = 1 + (days_passed % 30)  , hour=0, minute=0, second=0, microsecond=0)
    monthly_timestamp = now.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
    yearly_timestamp = now.replace(month=1, day=1, hour=0, minute=0, second=0, microsecond=0)
    while True:
        time.sleep(600)
        try:
            hourly_banana_value = round(mean(BananaTechVals), 2)
            BananaTechDailyVals.append(hourly_banana_value)
            hourly_chimp_value = round(mean(HealthyChimpVals), 2)
            HealthyChimpDailyVals.append(hourly_chimp_value)
            hourly_ecovine_value = round(mean(EcoVineVals), 2)
            EcoVineDailyVals.append(hourly_ecovine_value)
            hourly_jungle_value = round(mean(JungleGoodsVals), 2)
            JungleGoodsDailyVals.append(hourly_jungle_value)
            stockVal = hourly_banana_value + hourly_chimp_value + hourly_ecovine_value + hourly_jungle_value
            hourly_data = {
                'BananaTech': hourly_banana_value,
                'HealthyChimp': hourly_chimp_value,
                'EcoVine': hourly_ecovine_value,
                'JungleGoods': hourly_jungle_value,
                'Stocks' : stockVal,
                'timestamp': hourly_timestamp
            }
            db.collection('hourly_data').add(hourly_data)
            
            if hours_passed % 24 == 0:
                days_passed += 1
                daily_banana_value = round(mean(BananaTechDailyVals), 2)
                BananaTechWeeklyVals.append(daily_banana_value)
                BananaTechMonthlyVals.append(daily_banana_value)

                daily_chimp_value = round(mean(HealthyChimpDailyVals), 2)
                HealthyChimpWeeklyVals.append(daily_chimp_value)
                HealthyChimpMonthlyVals.append(daily_chimp_value)

                daily_ecovine_value = round(mean(EcoVineDailyVals), 2)
                EcoVineWeeklyVals.append(daily_ecovine_value)
                EcoVineMonthlyVals.append(daily_ecovine_value)


                daily_jungle_value = round(mean(JungleGoodsDailyVals), 2)
                JungleGoodsWeeklyVals.append(daily_jungle_value)
                JungleGoodsMonthlyVals.append(daily_jungle_value)


                stocks = daily_banana_value  +daily_chimp_value + daily_ecovine_value + daily_jungle_value
                daily_data = {
                    'banana': daily_banana_value,
                    'chimp': daily_chimp_value,
                    'ecovine': daily_ecovine_value,
                    'jungle': daily_jungle_value,
                    'timestamp': daily_timestamp
                }
                db.collection('daily_data').add(daily_data)

            if days_passed % 7 == 0:

                weekly_banana_value = round(mean(BananaTechWeeklyVals), 2)
                weekly_chimp_value = round(mean(HealthyChimpWeeklyVals), 2)
                weekly_ecovine_value = round(mean(EcoVineWeeklyVals), 2)
                weekly_jungle_value = round(mean(JungleGoodsWeeklyVals), 2)
                Stocks = weekly_banana_value + weekly_chimp_value + weekly_ecovine_value + weekly_jungle_value

                weekly_data = {
                    'banana': weekly_banana_value,
                    'chimp': weekly_chimp_value,
                    'ecovine': weekly_ecovine_value,
                    'jungle': weekly_jungle_value,
                    "Stocks": stocks,
                    'timestamp': weekly_timestamp
                }


                db.collection('weekly_data').add(weekly_data)

            if days_passed % 31 == 0:

                monthly_banana_value = round(mean(BananaTechMonthlyVals), 2)
                monthly_chimp_value = round(mean(HealthyChimpMonthlyVals), 2)
                monthly_ecovine_value = round(mean(EcoVineMonthlyVals), 2)
                monthly_jungle_value = round(mean(JungleGoodsMonthlyVals), 2)
                stocks = monthly_banana_value + monthly_chimp_value + monthly_ecovine_value + monthly_jungle_value

                monthly_data = {
                    'banana': monthly_banana_value,
                    'chimp': monthly_chimp_value,
                    'ecovine': monthly_ecovine_value,
                    'jungle': monthly_jungle_value,
                    'Stocks' : stocks,
                    'timestamp': monthly_timestamp
                }
                db.collection('monthly_data').add(monthly_data)

            

        except Exception as e:
            print(f"Error consolidating data: {e}")

        time.sleep(3000)
        hours_passed += 1

def start():
    while True:
        with app.app_context():  
            on_request_example(None)  
        time.sleep(60)  

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    global lastBanana, lastChimp, LastEconVine, LastJungle
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

    stocksPrintData = {
        'banana': BananaTechValue,
        'chimp': HealthyChimpValue,
        'ecovine': EcoVineValue,
        'jungle': JungleGoodsValue,
        'Stocks': (BananaTechValue + HealthyChimpValue + EcoVineValue +JungleGoodsValue),
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    stocksData = {
        'Stocks': (BananaTechValue + HealthyChimpValue + EcoVineValue +JungleGoodsValue),
        'timestamp': firestore.SERVER_TIMESTAMP
    }

    bananaData = {
        'value': BananaTechValue,
        'timestamp' : firestore.SERVER_TIMESTAMP,
    }
    chimpData = {
        'value': HealthyChimpValue,
        'timestamp' : firestore.SERVER_TIMESTAMP,
    }
    ecoData = {
        'value': EcoVineValue,
        'timestamp' : firestore.SERVER_TIMESTAMP,
    }
    jungleData = {
        'value': JungleGoodsValue,
        'timestamp' : firestore.SERVER_TIMESTAMP,
    }
    


    lastBanana = BananaTechValue
    lastChimp = HealthyChimpValue
    LastEconVine = EcoVineValue
    LastJungle = JungleGoodsValue
    print(f"Adding stocks {stocksPrintData}")

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
        return response

threading.Thread(target=start, daemon=True).start()
threading.Thread(target=consolidate_data, daemon=True).start()