FROM hashicorp/terraform:latest AS source
FROM scratch AS export
COPY --from=source /bin/terraform /terraform