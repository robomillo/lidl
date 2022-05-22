## Data Architecture Challenge
#### 1. What tracking events would you propose? What data model for event analysis? What technologies?

A single event type for tracking entry and exit from the parking lot is adequate as the predictive model is essentially
going to be a forcasting model based on time series analysis.

``` python
class EventSchema:
    event_type: Enum[Entry, Exit]
    timestamp: TIMESTAMP
    user_id: UUID
```

Events should be kept as simple as possible and any attribute data should live in a standard backend relational database.
Events can be written directly to application databases like mysql/postgres.

---
#### 2. How would you design the Backend system? 3. Explain how to combine the operational architecture with the analytical one?
[![](https://mermaid.ink/img/pako:eNp1UsGOgjAQ_ZWmp5roD3gwQcCNURNd0Qt4GKFoI7SkLbtxCf--hYIaduVAZua9eTNvoMKxSCie4ouE4orWnxFH5lHl2RbcjFGukVMUGYtBM8EtoZAiIcT_asCticuYSoVGI4tSnjxpaDKZIWeg63DI7prFytaPhMyXSAuRqV4jqDZrFEhgnPFLbWuHmbNdngYzHpq7EjKm72gjONNCmjZL2BHyISEFDn_2e-7zNIg80HAGRbvdnJD8h45OjS-PnukPK3NC-qif0ecNax6GK2exclAgChafhg7m7YncN3bMeWOq1MMOcqsVpDfYa0khr9tebzCgKe7eec3NTbsd22bf6rmCqzKnsru130CLkOy5-E4zuBnDA0H7XrQax9ckeE0OeIyNqhmamN-saqAI6yvNaYSnJkxA3iIc8drwyiIBTf2k-Xx4mkKm6BhDqcX-zmM81bKkPcljYNzkHav-BSaG3mY)](https://mermaid.live/edit#pako:eNp1UsGOgjAQ_ZWmp5roD3gwQcCNURNd0Qt4GKFoI7SkLbtxCf--hYIaduVAZua9eTNvoMKxSCie4ouE4orWnxFH5lHl2RbcjFGukVMUGYtBM8EtoZAiIcT_asCticuYSoVGI4tSnjxpaDKZIWeg63DI7prFytaPhMyXSAuRqV4jqDZrFEhgnPFLbWuHmbNdngYzHpq7EjKm72gjONNCmjZL2BHyISEFDn_2e-7zNIg80HAGRbvdnJD8h45OjS-PnukPK3NC-qif0ecNax6GK2exclAgChafhg7m7YncN3bMeWOq1MMOcqsVpDfYa0khr9tebzCgKe7eec3NTbsd22bf6rmCqzKnsru130CLkOy5-E4zuBnDA0H7XrQax9ckeE0OeIyNqhmamN-saqAI6yvNaYSnJkxA3iIc8drwyiIBTf2k-Xx4mkKm6BhDqcX-zmM81bKkPcljYNzkHav-BSaG3mY)

This is a model I have seen a number of times in the companies I have worked at. Client applications like mobile apps are connected directly
to traditional relational databases like mysql. These mysql databases contain all event data alongside traditional normalized tables
containing attributes like user information. All changes, inserts, updates, deletitions are then streamed as events into a kafka
topic using a tool like debezium. Some quality checks and transformers are applied to the kafka topic using KafkaStreams or
traditional KafkaConsumers and then streamed into the datawarehouse like Snowflake.

These structure fits very well with the merging of the analytical architecture to the operational.

##### What data model for the Operational system?
The Datamodel for the operation system should be a traditional relational database with a normalized structure.

#### 4. Could you propose a process to manage the development lifecycle? And the test and deployment automation?

The standard approach in such a system would be Contious Integration style git driven release lifecycle. Developers work
is continually integrated into the master branch on a daily basis backed by rigorous and fast test suites.
Feature flags can be implemented to ensure a features not ready for production deployment are still integrated into master
but are never enabled in the product until manually approved.



