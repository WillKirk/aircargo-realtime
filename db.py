import pymysql

db_config = {
        'host': 'cn7028-coursework-database.cteewm6uylwo.eu-west-2.rds.amazonaws.com',
        'user': 'admin',
        'password': 'Perturabo101!',
        'database': 'airfreight'
}

def get_db():
    return pymysql.connect(**db_config)
