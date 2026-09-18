# MongoDB Wire Compression

## MongoDB Wire Compression

Wire compression reduces the size of messages exchanged between DecisionRules server and the database. It can lower bandwidth usage and improve large-document or large-result-set transfers, at the cost of additional CPU usage.

Wire compression is separate from database storage compression and TLS encryption.

### Configuration

DecisionRules Docker reads the MongoDB connection string from `MONGO_DB_URI`. Enable compression with its `compressors` parameter:

```
mongodb://user:password@host:27017/database?compressors=zstd,zlib
```

When multiple algorithms are listed, the driver and server negotiate the first mutually supported option. If none is shared, the connection is normally left uncompressed. [MongoDB connection options](https://www.mongodb.com/docs/manual/reference/connection-string-options/)

DecisionRules does not enable compression automatically.

### Compressor options

<table><thead><tr><th width="159.6875">Compressor</th><th>Characteristics</th><th>DecisionRules 1.26.2+</th></tr></thead><tbody><tr><td><code>zstd</code></td><td>Good balance of compression ratio and CPU usage; recommended by MongoDB for most workloads.</td><td>Supported</td></tr><tr><td><code>zlib</code></td><td>Broad MongoDB compatibility and configurable compression level, but generally higher CPU usage.</td><td>Supported</td></tr></tbody></table>

### Recommendations

* Use `compressors=zstd,zlib` for MongoDB or Atlas after measuring CPU and network usage.
* Do not configure compression on DocumentDB versions earlier than 8.0.1.
* Leave compression disabled for Cosmos RU and Azure DocumentDB until it has been verified against the deployed service.
* Test with representative large payloads. Small messages may become slower because compression overhead can exceed the bandwidth savings.
* Confirm the negotiated compressor rather than treating a successful connection as proof that compression is active. Unsupported algorithms can silently result in an uncompressed connection.
