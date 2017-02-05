from twilio.rest import TwilioRestClient

# put your own credentials here
ACCOUNT_SID = "ACeab64fc8375c9d2de92a3553f84db779"
AUTH_TOKEN = "8a85c6f838a7713cd193fca07506e377"

client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)

client.messages.create(
    to="+16048121916",
    from_="+15017250604",
    # 17786537724
    body="This is the ship that made the Kessel Run in fourteen parsecs?",
    media_url="https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg",
)
