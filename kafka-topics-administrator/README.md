# Kafka Topics Administrator

Kafka Topics Administrator helps managing topics in a Kafka cluster.

Features:

- Creation of topics based on default values (provided by a settings file)
- Deletion of topics
- Listing / describing topics

## Build

Use the distribution plugin of Gradle:

1. In the root directory: `./gradlew clean assembleDist`
2. `cd` into `build/distributions`
3. `mv` either the `.tar.gz` or the `.zip` to your bin directory and unzip the archive

## Usage

Go to the newly created directory and run `bin/kafka-topics-administrator`. You should see now
a comprehensive list of possible actions.

### Topics settings file

You must provide a topics settings file either by setting `topics.config.path` in
`config.properties` or by defining a path via the `-t` command line option.
The program expects a `YAML` file with the following structure:

```yaml
defaults:               # For defining default settings (object and all fields optional)
  partitions: 4         # Default number of partitions
  replicationFactor: 2  # Default replication factor
  configurations:       # List of default topics settings as key=value
  - cleanup.policy=compact    # A default configuration
topics:                 # List of all predefined topics
  - name: topicName       # Name of topic (required)
    partitions: 2         # Number of partitions (required for create command if no default and no command line override provided)
    replicationFactor: 1  # Replication factor (required for create command if no default and no command line override provided)
    configurations:       # List of further configurations (optional)
    - delete.retention.ms=1000000
    - max.message.bytes=12323
  - name: anotherTopic
    # ...
```

For further configurations see the [topics configuration section](https://kafka.apache.org/documentation/#topicconfigs)
in the official Kafka documentation.

While creating topics, you can define ad-hoc settings via the `-s` flag which overrides the settings defined in the `YAML` file.
