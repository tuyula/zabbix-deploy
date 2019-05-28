import pymysql


def query_mysql(sql):
    conn = pymysql.connect(
        host='116.62.43.78',
        port=3306,
        user='root',
        password='e8ggdfscWsg!KCVKEU7',
        db="yfsrobot"
    )
    cur = conn.cursor()
    cur.execute(sql)
    for r in cur.fetchall():
        res = r
        # print(res)
    conn.close()
    for a in res:
        res_out = int(a)
        #print(res_out)
        return res_out

ai1_sql = "SELECT sum(currentnum) FROM aims WHERE remote_addr LIKE '47.96.115.28%'"
jinlun_sql = "SELECT sum(currentnum) FROM aims WHERE remote_addr LIKE '116.62.211.177%'"
liyue_sql = "SELECT sum(currentnum) FROM aims WHERE remote_addr LIKE '120.27.221.86%'"

res_total = query_mysql(ai1_sql) + query_mysql(jinlun_sql) + query_mysql(liyue_sql)
print(res_total)
