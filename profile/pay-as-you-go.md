# Pay As You Go

{% hint style="info" %}
This functionality is available only for plan subscriptions, not for free trial.
{% endhint %}

### **Overview**

The Pay-as-you-Go functionality enables you to use Audit logs and Jobs regardless of the limit that is set in your Plan. When you switch this functionality on, you will be able to use Audit logs and Jobs as you wish and will be charged accordingly for the consumption over the limit.

### **Setting**

The Pay-as-you-Go functionality can be switched on and off in the [Settings](settings.md) section of User Profile, independently for Audit Logs and Jobs.

#### **Audit logs**

When the Pay-as-you-Go is switched off, audit logs are generated and stored only to the limit set in your Plan (_Free BI Audit Logs_). Once you reach the limit, new audit logs are not generated. To generate more audit logs, free up some space manually (deleting logs) or using Business Intelligence API (retrieving logs into your BI application), or switch on the Pay-as-you-Go.

When the Pay-as-you-Go is switched on, new audit logs will be generated and stored even if you have already reached the limit in the plan. You will be charged for each day of the storage of logs that are over the limit (see below). To avoid unnecessary the costs, retrieve or delete the logs more frequently.

#### **Jobs**

When the Pay-as-you-Go is switched off, jobs are run only to the limit set in your Plan. Once you reach the limit, new jobs can not be started. To start more jobs, switch on the Pay-as-you-Go.

When the Pay-as-you-Go is switched on, new jobs can be started even if you have already reached the limit in the plan. You will be charged for the execution seconds that are over the limit.

### **Actual consumption and spend**

The actual consumption of Audit logs and Jobs can be found in the [Space Dashboard](/broken/pages/6Faa9KR0v9SjpeHC664D) as well as in the [Profile Dashboard](dashboard.md) (sum for all managed spaces).

The actual estimated spend for Audit logs and Jobs (if the Pay-as-you-Go is switched on) can be found in the [Profile Dashboard](dashboard.md) (sum for all managed spaces).

### **How the spend is calculated for audit logs**

For audit logs, the limit in the plan sets number of audit logs that can be stored free of charge each day.

* With the Pay-as-you-Go switched off, you will be able to store each day only limited number of logs and will not be charged any extra costs.
* With the Pay-as-you-Go switched on
  * you will be charged for each day when the number of stored logs exceeds the limit (regardless of whether the logs were created on the same day or before), using the unit price and number of logs over the limit.
  * if you manage to retrieve/delete you logs until the end of the day, you will not be charged for them

Here you can find a simple example of how the audit logs are counted during the billing period.&#x20;

This chart shows the number of logs stored each day during the billing period.

* **Blue bars** represent logs that fall within the free daily limit of **5,000 logs**. Black numbers shows total number of logs stored that day.
* **Yellow segments** (on top of the blue bars) represent logs that **exceed the daily free limit**. These over-limit logs are the ones that count towards your billing. T**he yellow numbers** indicate the exact count of logs above the free limit for that day.
* The **horizontal red line** marks the free daily limit of **5,000 logs**, so you can easily see which days stayed within the limit and which days went over.

<figure><img src="../.gitbook/assets/Audit Logs per billing period.png" alt=""><figcaption></figcaption></figure>

In the chart above, the yellow values show the logs that exceeded the free daily limit. These over-limit logs add up to **4,700** for the billing period and represent the amount that will be billed.

### **Billing**

Costs related to Audit logs and Jobs are billed monthly. A separate item on the plan invoice, or a standalone invoice (based on a plan that you have) is generated for these services.
