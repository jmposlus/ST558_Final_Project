FROM rocker/r-ver:3.5.0
RUN apt-get update -qq && apt-get install -y libssl-dev libcurl4-gnutls-dev
RUN R -e "install.packages('GGally')"
RUN R -e "install.packages('plumber')"
COPY api.R api.R
EXPOSE 8000
ENTRYPOINT ["R", "-e", \
            "pr <- plumber::plumb('myAPI.R'); pr$run(host='0.0.0.0', port=8000)"]