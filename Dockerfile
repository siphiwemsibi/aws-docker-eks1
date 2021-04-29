FROM python:alpine3.10

WORKDIR /appcode

COPY ./requirements.txt /appcode/requirements.txt

RUN pip install -r requirements.txt

COPY source/ . 

ENTRYPOINT ["python3", "./myapp.py"]