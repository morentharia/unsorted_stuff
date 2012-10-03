#!/usr/bin/env python
# vim:fileencoding=utf8


from pprint import pprint
import requests
import json
# import sys
from datetime import date, timedelta
from dateutil.rrule import rrule, DAILY
from dateutil.rrule import MO, TU, WE, TH, FR
# from dateutil.rrule import SU, SA
import random
import copy
from itertools import groupby

KEY = '****************************************'
URL = "https://redminehost.ru"
TIME_ENTRIES_URL = URL + "/time_entries.xml"

WORKING_HOURS = 8.0


# <option value="8" selected="selected">Планирование</option>
# <option value="9">Разработка</option>
# <option value="10">Тестирование</option></select>

TIME_ENTRIES_WEIGHT = [
    (0.5, dict(issue_id="25476",
               activity_id="8",
               hours="3.0",
               comments="таск 2 ",
               spent_on="%Y-%m-%d")),
    (0.5, dict(issue_id="25476",
               activity_id="8",
               hours="2.0",
               comments="таск 1",
               spent_on="%Y-%m-%d")),
    (1.0, dict(issue_id="25476",
               activity_id="10",
               hours="2.5",
               comments="очень важно ",
               spent_on="%Y-%m-%d")),
    (3.0, dict(issue_id="25476",
               activity_id="9",
               hours="5.0",
               comments="не очень важно ",
               spent_on="%Y-%m-%d")),
    (2.0, dict(issue_id="25476",
               activity_id="9",
               hours="3.0",
               comments="и  так далее",
               spent_on="%Y-%m-%d")),
]


def daterange(start_date, end_date):
    return rrule(DAILY, dtstart=start_date, until=end_date,
                 byweekday=(MO, TU, WE, TH, FR))


def key_func(time_entry):
    return float(time_entry['hours'])


def key_func_set(time_entry, val):
    time_entry['hours'] = str(val)


def random_time_entries(time_entries_weight,
                        total_amount_hours=0):
    time_entries = []
    total_weight = sum([a for (a, b) in time_entries_weight])
    while total_amount_hours > 0:
        entry_choice = random.random() * total_weight

        weight_sum = 0
        for (weight, payload) in time_entries_weight:
            weight_sum += weight
            if weight_sum > entry_choice:
                total_amount_hours -= key_func(payload)
                if total_amount_hours >= 0:
                    time_entries.append(payload)
                else:
                    tmp = copy.deepcopy(payload)
                    key_func_set(tmp, key_func(payload) + total_amount_hours)
                    time_entries.append(tmp)
                break
    return time_entries


def group_time_entries(time_entries):
    res = []  # [ dict(issue_id="15192", activity_id="9", hours="9.5",
              #        comments="читал комиксы", spent_on="%Y-%m-%d")), ... , ]
    for key, lst in groupby(time_entries):
        hours_sum = sum([key_func(i) for i in lst])
        tmp = copy.deepcopy(key)
        key_func_set(tmp, hours_sum)
        res.append(tmp)
    return res


def split_by_day(time_entries, working_hours=8.0):
    sum = 0
    one_day = []
    for i in time_entries:
        tmp = copy.deepcopy(i)
        while sum + key_func(tmp) > working_hours:
            a = working_hours - sum
            key_func_set(tmp, key_func(tmp) - a)

            if a != 0.0:
                tmp_2 = copy.deepcopy(tmp)
                key_func_set(tmp_2, a)
                one_day.append(tmp_2)
            yield one_day

            sum = 0
            one_day = []

        sum += key_func(tmp)
        one_day.append(tmp)
    yield one_day


if __name__ == '__main__':
    today = date.today()
    start_date = date(today.year, today.month, 10)
    # end_date = date(today.year, today.month + 1, 1) + timedelta(days=-1)
    end_date = start_date + timedelta(days=20)

    total_amount_hours = sum([WORKING_HOURS for i in daterange(start_date,
                                                               end_date)])

    # total_amount_hours = 18.0
    time_entries = random_time_entries(TIME_ENTRIES_WEIGHT,
                                       total_amount_hours=total_amount_hours)
    time_entries = group_time_entries(time_entries)

    print
    sum_hours = 0
    res = []
    for lst, d in zip(split_by_day(time_entries), daterange(start_date,
                                                            end_date)):
        print
        print '=========================='
        print
        for i in lst:
            i['spent_on'] = d.strftime("%Y-%m-%d")
            print i['spent_on'], i['issue_id'], i['comments'], i['hours']
            sum_hours += float(i['hours'])
            res.append(i)

    print
    print "sum :", sum_hours
    print

    # with open('results.json', 'w') as f:
    #     f.write(json.dumps(res, indent=2));

    def print_request(args):
        pprint(args.url)
        pprint(args.params)
        pprint(args.headers)
        pprint(args.data)

    # """
    print KEY
    for payload in res:
        r = requests.post(TIME_ENTRIES_URL,
                          params=dict(key=KEY),
                          data=json.dumps(dict(time_entry=payload)),
                          # verify=True,
                          hooks=dict(pre_request=print_request),
                          headers = {'Content-Type': 'application/json'},)

        # print r.raw.read()
        pprint(r.text)
        pprint(r.headers)
        print r.status_code
    # """

    # # sys.exit(1)
