from flask import Flask
from flask import request
from flask import render_template

from apscheduler.schedulers.background import BackgroundScheduler
from datetime import datetime
from threading import Timer
import random
import json

import twilio.twiml
from send_sms import send_sms

# Sets schedules for sms sending
sched = BackgroundScheduler()
content = []

# @sched.scheduled_job('interval', seconds=10)
# def timed_job():
#     print('This job is run every 10 seconds.')

@sched.scheduled_job('cron', day_of_week='mon-sun', hour=16)
def scheduled_afternoon_message():
    send_sms(random.choice(content))

@sched.scheduled_job('cron', day_of_week='mon-sun', hour=10)
def scheduled_morning_message():
    send_sms(random.choice(content))

app = Flask(__name__)

# Main server page where you can manually send sms
@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'GET':
        resp = twilio.twiml.Response()
        resp.message("Hello, Mobile Monkey")

    return render_template("server_page.html")

@app.route('/submission', methods=['POST'])
def form(display=None):
    query = request.form['phoneNum']
    send_sms(random.choice(content))
    return render_template("success.html")

if __name__ == "__main__":
    # Load messages
    with open("messages.txt") as f:
        content = f.readlines()
    content = [x.strip() for x in content]
    # Start the scheduler when the server is on
    sched = BackgroundScheduler()
    sched.start()
    app.run()
