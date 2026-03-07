# Challenge 5: Load Testing & Performance Validation

> **Duration**: 30 minutes | **Agent**: `design` | **Output**: `05-load-test-results.md`

## The Business Context

Nordic Fresh Foods expects 500 concurrent users during peak seasons (summer and December holidays).
Before going live, they need confidence that the infrastructure can handle this load with acceptable performance.

## Your Challenge

Validate that your deployed infrastructure meets these performance targets:

| Metric                  | Target     | Business Rationale                           |
| ----------------------- | ---------- | -------------------------------------------- |
| **Concurrent Users**    | 500        | Peak holiday season traffic                  |
| **Response Time (P95)** | ≤2 seconds | User experience / cart abandonment threshold |
| **Error Rate**          | ≤1%        | Acceptable failure rate for MVP              |
| **Sustained Duration**  | 5 minutes  | Verify no degradation under sustained load   |

## Option 1: k6 Load Testing (Recommended)

k6 is pre-installed in your Dev Container for quick load testing.

### Create Your Test Script

**Consider these questions**:

- What endpoint should you test? (Homepage? API? Both?)
- How should you ramp up? (0→500 gradually or immediate spike?)
- What constitutes a "passed" test?
- What metrics matter most for this business?

**Basic Test Structure** (expand based on your needs):

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '?', target: ? },   // How should you ramp up?
    { duration: '?', target: ? },   // How long to sustain peak?
    { duration: '?', target: ? },   // How to ramp down?
  ],
  thresholds: {
    http_req_duration: ['p(95)<2000'],  // Why P95? Why not P99?
    http_req_failed: ['rate<0.01'],     // Why 1%? What if it's 2%?
  },
};

export default function () {
  const res = http.get('https://YOUR-APP-URL');  // What URL?
  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 2s': (r) => r.timings.duration < 2000,
  });
  sleep(1);  // Why sleep? What does this simulate?
}
```

### Run the Test

```bash
k6 run load-test.js
```

**Watch for**:

- Does P95 stay under 2 seconds?
- Does error rate stay under 1%?
- Are there any anomalies during ramp-up?

## Option 2: Azure Load Testing (If you have more time)

```bash
az load create \
  --name lt-freshconnect \
  --resource-group rg-freshconnect-dev-swc \
  --location swedencentral
```

Then upload your test script through the Azure Portal.

## Generating Your Load Test Report

After running your tests, use the **`design` agent** to create a professional test results document.

### Prompt Template for the `design` Agent

**Why use the `design` agent?**

- It structures raw data into professional documentation
- It extracts key insights from test output
- It follows documentation standards
- It saves you time formatting

**Suggested Prompt**:

```
Create a load test results document for the FreshConnect infrastructure.

Test Output:
[paste your k6 summary here]

Requirements:
- Document name: 05-load-test-results.md
- Include: test configuration, results summary, pass/fail status
- Add: observations about performance patterns
- Recommend: any optimizations needed for production
- Format: professional technical documentation

Context:
- Target: 500 concurrent users
- P95 threshold: 2 seconds
- Error rate threshold: 1%
- Business criticality: MVP launch depends on these results
```

**This demonstrates**:

1. How to structure prompts for documentation tasks
2. How to provide context for better agent output
3. How to specify format and content requirements

## Interpreting Your Results

### ✅ If Tests Pass

**Questions to consider**:

- What was the actual P95? How much headroom do you have?
- Were there any performance degradation patterns?
- What happens at 600 users? 1000 users?
- Should you recommend auto-scaling to the client?

### ❌ If Tests Fail

**Diagnostic questions**:

| Symptom               | Possible Causes                  | Where to Investigate             |
| --------------------- | -------------------------------- | -------------------------------- |
| High P95 (>2s)        | Under-provisioned compute        | App Service SKU, SQL DTUs        |
| Error rate >1%        | Connection limits, timeouts      | SQL connection pool, App timeout |
| Timeouts              | Cold start, initialization delay | App Service "Always On" setting  |
| Degradation over time | Memory leak, resource exhaustion | Application Insights metrics     |

**How to improve**:

- What would you change in your Bicep?
- How would you prompt the `bicep-code` agent to scale up?
- What's the cost impact of scaling?

## Success Criteria

| Criterion                                  | Points |
| ------------------------------------------ | ------ |
| Load test executed with realistic scenario | 2      |
| Results documented (using `design` agent)  | 2      |
| Performance interpreted correctly          | 1      |
| **Total**                                  | **5**  |

## Coaching Questions

**Before running tests**:

- Q: "What endpoint should I test?"
- A: What represents the critical user journey? Homepage? API? Checkout flow?

**After seeing results**:

- Q: "My P95 is 2.5 seconds. Is that a failure?"
- A: What did the business say was acceptable? What's the user impact? What's the cost to fix it?

**For the documentation**:

- Q: "Should I include all the k6 output?"
- A: What information helps the client make decisions? What's noise vs signal?

## Time Management

💡 **5 minutes**: Design your load test script
💡 **5 minutes**: Run load test and observe metrics in real time
💡 **5 minutes**: Analyze results and identify patterns
💡 **10 minutes**: Use `design` agent to generate professional documentation
💡 **5 minutes**: Iterate on failures or explore Azure Load Testing (if time permits)

> [!NOTE]
> Final scoring uses the criteria in the
> [Scoring Rubric](../facilitator/scoring-rubric.md),
> which is the single source of truth for all point values.

## Next Steps

After validating performance, proceed to [Challenge 6: Documentation](challenge-6-documentation.md)
to create comprehensive workload documentation.

Create a deployment summary and prepare for team showcase!
