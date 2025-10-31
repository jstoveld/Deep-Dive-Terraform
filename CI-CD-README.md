# CI/CD Pipeline Documentation

## Overview
This repository uses GitHub Actions for continuous integration and deployment of Terraform infrastructure.

## Workflows

### 1. Terraform CI/CD (`terraform.yml`)
**Triggers:**
- Push to `main` branch (only when `globo-networking/` files change)
- Pull requests to `main` branch (only when `globo-networking/` files change)

**Features:**
- Single directory focus (globo-networking) to prevent multiple runs
- Security scanning with Checkov
- Terraform plan comments on PRs
- Automatic apply on main branch
- Format and validation checks
- Concurrency control to prevent overlapping runs

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

## Key Features to Prevent Multiple Runs

### Path-Based Filtering
The workflow only runs when files in `globo-networking/` change:
```yaml
on:
  push:
    paths:
      - 'globo-networking/**'
```

### Concurrency Control
Prevents multiple workflow runs from the same ref:
```yaml
concurrency:
  group: terraform-${{ github.ref }}
  cancel-in-progress: false
```

### Single Directory Focus
- Targets only `globo-networking` directory
- Uses `working-directory: globo-networking`
- Avoids matrix strategy that creates multiple jobs

## Troubleshooting

### Common Issues

1. **Workflows Not Running**
   - Ensure workflows are in `.github/workflows/` at repository root
   - Check that file changes match the `paths` filter
   - Verify workflow files have `.yml` or `.yaml` extension

2. **Multiple Terraform Cloud Runs**
   - This should now be resolved with single directory focus
   - Concurrency control prevents overlapping runs
   - Path filtering ensures minimal triggers

3. **Missing TF_API_TOKEN**
   - Ensure the secret is set in repository settings
   - Token must have appropriate Terraform Cloud permissions

4. **Workspace Not Found**
   - Verify workspace names in `terraform.tf` files
   - Ensure workspaces exist in Terraform Cloud

## Monitoring
- Check the Actions tab for workflow runs
- Review Security tab for scan results
- Monitor Terraform Cloud for apply status

## File Structure
```
.github/
  workflows/
    terraform.yml    # Main Terraform CI/CD
    security.yml     # Security scanning
globo-networking/    # Target directory for Terraform
  terraform.tf       # Terraform configuration
  ...
```