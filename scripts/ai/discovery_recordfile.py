import os
import sys
import json


def discovery_record_parser():
    record_file_path = sys.argv[1]

    if not record_file_path:
        print "Can`t find record_path"
        return

    file_path_l = record_file_path.split(',')
    file_path_l = [{"{#FILEPATH}": "{}".format(file_path)} for file_path in file_path_l if os.path.isdir(file_path)]
    print json.dumps({'data': file_path_l}, sort_keys=True, indent=4)


discovery_record_parser()