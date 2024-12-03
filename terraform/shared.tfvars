public_domain_name = "manasi.io"
aws_region         = "eu-west-3"
# aws_region          = "us-east-1"
port_db             = 5432
port_backend        = 8080
port_backend_https  = 1024
port_frontend       = 4200
port_frontend_https = 443
port_pichat_pickle  = 8000
ec2_timezone        = "Europe/Paris"

buckets = {
  PirogFront      = "front"
  SharedFronts    = "shared-fronts"
  SharedArtifacts = "shared-artifacts"
  SharedLogging   = "shared-logging"
  SharedOps       = "shared-ops"
  Tfstate         = "tfstate"
}

components = {
  App           = "APP"
  Front         = "FRONT"
  Back          = "BACK"
  Bdd           = "RDS"
  NoSQL         = "DYNAMODB"
  Infra         = "INFRA"
  Bucket        = "S3"
  Transverse    = "TRANSVERSE"
  Secret        = "SECRET"
  Lambda        = "LAMBDA"
  SecurityGroup = "SG"
  Role          = "ROLE"
  Policy        = "POLICY"
  Queue         = "SQS"
  Instance      = "EC2"
  API           = "APIGATEWAY"
  ECR           = "CONTAINER_REPO"
  ECS           = "CONTAINER_SERVICE"
}

