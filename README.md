# Chronicle

*Simple Swift Logger in under 90 loc*

## [Log 🪵 Message Format](https://github.com/0xLeif/Chronicle/blob/c2d5ea4e3db3810ae67c4ba08372feb9d98da2e7/Sources/Chronicle/Chronicle.swift#L80)

**`{Date} {Label} {Emoji}: {Message}`**

### Default Format

4/5/21, 7:05:42 PM CDT [com.example.chronicle] ℹ️: Info
```
Date = 4/5/21, 7:05:42 PM CDT
Label = [com.example.chronicle]
Emoji = ℹ️
Message = Info
```

## Examples

### Default Chronicle
```swift
let chrono = Chronicle(
    label: "com.example.chronicle"
)

enum SomeError: Error { case abc }

chrono.log(level: .success("Success"))
chrono.log(level: .info("Info"))
chrono.log(level: .warning("Warning"))
chrono.log(level: .error("Error", SomeError.abc))
chrono.log(level: .fatal("Fatal", SomeError.abc))
```

**Logging**
```
4/5/21, 7:05:42 PM CDT [com.example.chronicle] ✅: Success
4/5/21, 7:05:42 PM CDT [com.example.chronicle] ℹ️: Info
4/5/21, 7:05:42 PM CDT [com.example.chronicle] ⚠️: Warning
4/5/21, 7:05:42 PM CDT [com.example.chronicle] ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
}
4/5/21, 7:05:42 PM CDT [com.example.chronicle] 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
}
```

### DateFormatter Chronicle
```swift
let dateFormatter = DateFormatter()
dateFormatter.timeStyle = .none
dateFormatter.dateStyle = .full

let chrono = Chronicle(
    label: "com.example.chronicle",
    dateFormatter: dateFormatter
)

enum SomeError: Error { case abc }

chrono.log(level: .success("Success"))
chrono.log(level: .info("Info"))
chrono.log(level: .warning("Warning"))
chrono.log(level: .error("Error", SomeError.abc))
chrono.log(level: .fatal("Fatal", SomeError.abc))
```

**Logging**
```
Monday, April 5, 2021 [com.example.chronicle] ✅: Success
Monday, April 5, 2021 [com.example.chronicle] ℹ️: Info
Monday, April 5, 2021 [com.example.chronicle] ⚠️: Warning
Monday, April 5, 2021 [com.example.chronicle] ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $100f876d8).(unknown context at $100f87724).SomeError error 0.)
}
Monday, April 5, 2021 [com.example.chronicle] 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $100f876d8).(unknown context at $100f87724).SomeError error 0.)
}
```

### LabelFormatter Chronicle
```swift
let chrono = Chronicle(
    label: "com.example.chronicle",
    labelFormatter: { "👉 \($0) 👈" }
)

enum SomeError: Error { case abc }

chrono.log(level: .success("Success"))
chrono.log(level: .info("Info"))
chrono.log(level: .warning("Warning"))
chrono.log(level: .error("Error", SomeError.abc))
chrono.log(level: .fatal("Fatal", SomeError.abc))
```

**Logging**
```
4/5/21, 7:27:47 PM CDT 👉 com.example.chronicle 👈 ✅: Success
4/5/21, 7:27:47 PM CDT 👉 com.example.chronicle 👈 ℹ️: Info
4/5/21, 7:27:47 PM CDT 👉 com.example.chronicle 👈 ⚠️: Warning
4/5/21, 7:27:47 PM CDT 👉 com.example.chronicle 👈 ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $100f87918).(unknown context at $100f87964).SomeError error 0.)
}
4/5/21, 7:27:47 PM CDT 👉 com.example.chronicle 👈 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $100f87918).(unknown context at $100f87964).SomeError error 0.)
}
```

### OutputFormatter Chronicle
```swift
let chrono = Chronicle(
    label: "com.example.chronicle",
    outputFormatter: { $0.emoji + " " + $0.output + " " + $0.emoji }
)

enum SomeError: Error { case abc }

chrono.log(level: .success("Success"))
chrono.log(level: .info("Info"))
chrono.log(level: .warning("Warning"))
chrono.log(level: .error("Error", SomeError.abc))
chrono.log(level: .fatal("Fatal", SomeError.abc))
```

**Logging**
```
4/5/21, 7:29:21 PM CDT [com.example.chronicle] ✅: ✅ Success ✅
4/5/21, 7:29:21 PM CDT [com.example.chronicle] ℹ️: ℹ️ Info ℹ️
4/5/21, 7:29:21 PM CDT [com.example.chronicle] ⚠️: ⚠️ Warning ⚠️
4/5/21, 7:29:21 PM CDT [com.example.chronicle] ❗️: ❗️ Error
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
} ❗️
4/5/21, 7:29:21 PM CDT [com.example.chronicle] 🚨: 🚨 Fatal
{
    abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
} 🚨
```
