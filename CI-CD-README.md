# CI/CD Pipeline Documentation

## Overview
This repository uses GitHub Actions for continuous integration and deployment of Terraform infrastructure.

## Workflows

### 1. Terraform CI/CD (`terraform.yml`)
**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**Features:**
- Multi-directory support (matrix strategy)
- Security scanning with Checkov
- Terraform plan comments on PRs
- Automatic apply on main branch
- Format and validation checks

**Required Secrets:**
- `TF_API_TOKEN`: Terraform Cloud API token

### 2. Security Scanning (`security.yml`)
**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch
- Weekly scheduled scans (Sundays at 2 AM UTC)

**Features:**
- Trivy vulnerability scanning
- Checkov infrastructure security scanning
- Results uploaded to GitHub Security tab

## Setup Instructions

### 1. Terraform Cloud Token
1. Go to [Terraform Cloud](https://app.terraform.io/)
2. Navigate to User Settings > Tokens
3. Create a new API token
4. Add it to GitHub repository secrets as `TF_API_TOKEN`

### 2. GitHub Repository Settings
Ensure the following permissions are enabled:
- **Actions**: Read and write permissions
- **Pull requests**: Write permissions
- **Security events**: Write permissions

### 3. Branch Protection (Recommended)
1. Go to repository Settings > Branches
2. Add rule for `main` branch:
   - Require status checks to pass before merging
   - Require branches to be up to date before merging
   - Include administrators

## Workflow Details

### Matrix Strategy
The workflow runs against multiple directories:
- `globo-networking`: Main networking configuration
- `m7/application_config_example`: Application example
- `m9/application_config_complete`: Complete application config

### Security Features
- **Checkov**: Scans for Terraform security issues
- **Trivy**: Scans for vulnerabilities in the codebase
- **SARIF uploads**: Results appear in GitHub Security tab

### Plan Comments
On pull requests, the workflow will:
1. Generate Terraform plans for each directory
2. Comment on the PR with plan details
3. Show what resources will be created/modified/destroyed

### Auto-Apply
- Only runs on pushes to `main` branch
- Applies the previously generated plan
- Uses `-auto-approve` flag

## Troubleshooting

### Common Issues

1. **Missing TF_API_TOKEN**
   - Ensure the secret is set in repository settings
   - Token must have appropriate Terraform Cloud permissions

2. **Workspace Not Found**
   - Verify workspace names in `terraform.tf` files
   - Ensure workspaces exist in Terraform Cloud

3. **Plan Failures**
   - Check AWS credentials configuration
   - Verify Terraform Cloud workspace settings
   - Review variable definitions

### Monitoring
- Check the Actions tab for workflow runs
- Review Security tab for scan results
- Monitor Terraform Cloud for apply status

## Customization

### Adding New Directories
Update the matrix strategy in `terraform.yml`:
```yaml
strategy:
  matrix:
    directory: [
      'globo-networking',
      'm7/application_config_example',
      'm9/application_config_complete',
      'your-new-directory'  # Add here
    ]
```

### Changing Terraform Version
Update the setup-terraform action:
```yaml
- name: Setup Terraform
  uses: hashicorp/setup-terraform@v3
  with:
    terraform_version: ~1.7.0  # Change version here
```