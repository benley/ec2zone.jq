#!/usr/bin/jq -f

(["$ORIGIN \($zone)"]
 +
 [
   .Reservations[].Instances[]
     | { InstanceId,
         PrivateIpAddress,
         PrivateDnsName,
         InstanceType,
         Name: .Tags
                 | map({key: .Key, value: .Value})
                 | from_entries
                 .Name
       }
     | ["\n; \(.PrivateDnsName)",
        "\(.Name).\($zone)  IN A     \(.PrivateIpAddress)",
        "\(.Name).\($zone)  IN TXT   \"id: \(.InstanceId)\"",
        "\(.Name).\($zone)  IN HINFO \"\(.InstanceType)\""
       ] | join("\n")
 ]
) | join("\n")
