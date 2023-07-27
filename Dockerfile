FROM python:3.11-bullseye

# create a working directory
RUN mkdir /app
WORKDIR /app

# copy the requirements.txt file
COPY requirements.txt .

# install the dependencies
RUN pip install -r requirements.txt

# copy the main files
COPY . .
COPY .env .

ARG PORT=80
ARG HOST=0.0.0.0

ENV PORT=${PORT}
ENV HOST=${HOST}
# expose the port for the FastAPI application
EXPOSE ${PORT}

# run the FastAPI application
CMD ["uvicorn", "app.main:app", "--reload", "--host", "$HOST", "--port", "$PORT"]

