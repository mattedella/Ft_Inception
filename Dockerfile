FROM python:3.10-alpine

WORKDIR /code

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "uvicorn", "app:app", "--host", "0.0.0.0", "--reload" ]