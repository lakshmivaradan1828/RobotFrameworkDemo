import smtplib
from imap_tools import MailBox

# This keyword uses smtplib builtin Python library
# https://docs.python.org/3/library/smtplib.html
def send_email(sent_from_email, sent_from_password, to_email, subject, message):
    email_text = 'Subject: {}\n\n{}'.format(subject, message)
    
    smtp_server = smtplib.SMTP('mail.volvo.net', 587)
    smtp_server.starttls()
    smtp_server.login(sent_from_email, sent_from_password)
    smtp_server.sendmail(sent_from_email, to_email, email_text)
    smtp_server.quit()
    print ("Email sent successfully!")

# This keyword uses imap_tools library to read emails.
# More info about library, messages filtering criteria etc.:
# https://github.com/ikvk/imap_tools
def read_emails(email, password):
    mb = MailBox("mail.volvo.net").login(email, password, initial_folder='INBOX')
    messages = mb.fetch()
    for msg in messages:
        print(msg.from_, ': ', msg.subject)
        print(msg.text)