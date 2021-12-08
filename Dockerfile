FROM moonwalkers/terraform:202112061807

WORKDIR /app

# Mount secrets .
RUN --mount=type=secret,id=GCP_CREDENTIAL,dst=/app/gcp.json cat gcp.json > /app/service-account.json
RUN --mount=type=secret,id=TERRAFORM_TOKEN,dst=/app/terraformrc cat /app/terraformrc > /app/.terraformrc
RUN --mount=type=secret,id=BUCKET,dst=/app/backend cat /app/backend > /app/backend.tf
RUN --mount=type=secret,id=TFVARS,dst=/app/tfvars cat /app/tfvars > /app/terraform.tfvars

# Set environment variables for GCP and Terraform credentials
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/service-account.json"
ENV TF_CLI_CONFIG_FILE="/app/.terraformrc"

RUN cat /app/terraform.tfvars
RUN cat /app/backend.tf

COPY entrypoint.sh .
ENTRYPOINT ["ash","entrypoint.sh"]
