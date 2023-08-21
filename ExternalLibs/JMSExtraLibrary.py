import logging
import pymqi
import sys
from pymqi import CMQC
import xml.dom.minidom
from time import sleep
import re
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# coding: utf8



def connect_to_MQ_manager(queue_manager, channel, host, port):
    #host = host.encode('utf-8')
    #port = port.encode('utf-8')
    conn_info = host+"("+port+")"
    #queue_manager = queue_manager.encode('utf-8')
    #channel = channel.encode('utf-8')
    global qmgr
    try:
        qmgr = pymqi.connect(queue_manager, channel, conn_info, False)
    except pymqi.MQMIError as e:
        if e.comp == pymqi.CMQC.MQCC_FAILED and e.reason == pymqi.CMQC.MQRC_HOST_NOT_AVAILABLE:
            logging.error('host [%s] is not available.' % host)
            # Exit here if host unknown ([ERROR] Stopped by user - will be displayed)
        sys.exit()

    return qmgr


def get_number_of_messages(queue_name):
    sleep(1)
    qmgr_get_no = qmgr
    #queue_name = queue_name.encode('utf-8')
    queue = pymqi.Queue(qmgr_get_no, queue_name)
    depth = queue.inquire(CMQC.MQIA_CURRENT_Q_DEPTH)
    print(depth)
    return depth
    queue.close()


def empty_queue(queue_name):  # possible exception MQRC_NO_MSG_AVAILABLE
    qmgr_empty = qmgr
    #queue_name = queue_name.encode('utf-8')
    try:
        queue = pymqi.Queue(qmgr_empty, queue_name)
        depth = queue.inquire(CMQC.MQIA_CURRENT_Q_DEPTH)
        print(depth, "message(s) in the queue")
        for i in range(depth):
            queue = pymqi.Queue(qmgr_empty, queue_name)
            queue.get_no_jms()
        queue = pymqi.Queue(qmgr_empty, queue_name)
        depth = queue.inquire(CMQC.MQIA_CURRENT_Q_DEPTH)
        if depth == 0:
            print("All messages removed")
        else:
            print("Something went wrong, messages could not be deleted")
    except pymqi.MQMIError as e:
        if e.reason == CMQC.MQRC_NO_MSG_AVAILABLE:
            logging.error(
                'Messages could not be deleted, try adding sleep or wait between sending and removing messages')
            # Exit here if host unknown ([ERROR] Stopped by user - will be displayed)
        sys.exit()
    queue.close()


# def send_message_to_queue(queue_name, message):
#     qmgr_send = qmgr
#     #queue_name = queue_name.encode('utf-8')
#     #message = message.encode('utf-8')
#     queue = pymqi.Queue(qmgr_send, queue_name)
#     md = pymqi.MD()
#     md.Format = CMQC.MQFMT_STRING
#     dom = xml.dom.minidom.parseString(message)
#     xml_message = dom.toprettyxml()
#     queue.put(xml_message, md)
#     print("Message has been sent")
#     queue.close()
def send_message_to_queue(queue_name, message):
    qmgr_send=qmgr
    queue = pymqi.Queue(qmgr_send, queue_name)
    md = pymqi.MD()
    md.Format = CMQC.MQFMT_STRING
    if (re.match(r'^<.+>$', message)):
        dom = xml.dom.minidom.parseString(message)
        message = dom.toprettyxml()
    queue.put(message, md)
    print("Message has been sent")
    queue.close()  



def get_all_messages_off_queue(queue_name):
    qmgr_get_all = qmgr
    #queue_name = queue_name.encode('utf-8')
    message_list = []
    try:
        queue = pymqi.Queue(qmgr_get_all, queue_name)
        depth = queue.inquire(CMQC.MQIA_CURRENT_Q_DEPTH)
        print(depth, "message(s) in the queue")
        for i in range(depth):
            queue = pymqi.Queue(qmgr_get_all, queue_name)
            message = queue.get_no_jms()
            message_list.append(message)
        queue = pymqi.Queue(qmgr_get_all, queue_name)
        depth = queue.inquire(CMQC.MQIA_CURRENT_Q_DEPTH)
        if depth == 0:
            print("All messages has been consumed")
        else:
            print("Something went wrong, messages could not be deleted")
    except pymqi.MQMIError as e:
        if e.reason == CMQC.MQRC_NO_MSG_AVAILABLE:
            logging.error(
                'Messages could not be deleted, try adding sleep or wait between sending and removing messages')
            # Exit here if host unknown ([ERROR] Stopped by user - will be displayed)
        sys.exit()
    return message_list
    queue.close()


def get_message_off_queue(queue_name):
    qmgr_get_message = qmgr
    #queue_name = queue_name.encode('utf-8')
    queue = pymqi.Queue(qmgr_get_message, queue_name)
    message = queue.get_no_jms()
    #message = queue.get()
    print("Message has been read")
    return message
    queue.close()


def wait_for_a_message(queue_name):  # 5 seconds by default
    # Message Descriptor
    md = pymqi.MD()
    # Get Message Options
    gmo = pymqi.GMO()
    gmo.WaitInterval = 5000  # 5 seconds
    qmgr_wait = qmgr
    #queue_name = queue_name.encode('utf-8')
    queue = pymqi.Queue(qmgr_wait, queue_name)
    print("Checking for messages")
    message_in_queue = queue.get_no_jms(None, md, gmo)
    print(message_in_queue)
    return message_in_queue
    queue.close()


def close_MQ_connection():
    qmgr_close = qmgr
    qmgr_close.disconnect()
