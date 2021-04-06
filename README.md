# Chronical

*Simple Swift Logger in under 90 loc*

## [Log 🪵 Message Format](https://github.com/0xLeif/Chronical/blob/546de4daa3fa150abf5fb430048a3e02adee5b92/Sources/Chronical/Chronical.swift#L80)

**`{Date} {Label} {Emoji}: {Message}`**

### Default Format

Monday, April 5, 2021 [com.example.chronical] ℹ️: Info
```
Date = Monday, April 5, 2021
Label = [com.example.chronical]
Emoji = ℹ️
Message = Info
```

## Examples

### Default Chronical
```swift
let chrono = Chronical(
    label: "com.example.chronical"
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
4/5/21, 7:05:42 PM CDT [com.example.chronical] ✅: Success
4/5/21, 7:05:42 PM CDT [com.example.chronical] ℹ️: Info
4/5/21, 7:05:42 PM CDT [com.example.chronical] ⚠️: Warning
4/5/21, 7:05:42 PM CDT [com.example.chronical] ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
}
4/5/21, 7:05:42 PM CDT [com.example.chronical] 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
}
```

### DateFormatter Chronical
```swift
let dateFormatter = DateFormatter()
dateFormatter.timeStyle = .none
dateFormatter.dateStyle = .full

let chrono = Chronical(
    label: "com.example.chronical",
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
Monday, April 5, 2021 [com.example.chronical] ✅: Success
Monday, April 5, 2021 [com.example.chronical] ℹ️: Info
Monday, April 5, 2021 [com.example.chronical] ⚠️: Warning
Monday, April 5, 2021 [com.example.chronical] ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $100f876d8).(unknown context at $100f87724).SomeError error 0.)
}
Monday, April 5, 2021 [com.example.chronical] 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $100f876d8).(unknown context at $100f87724).SomeError error 0.)
}
```

### LabelFormatter Chronical
```swift
let chrono = Chronical(
    label: "com.example.chronical",
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
4/5/21, 7:27:47 PM CDT 👉 com.example.chronical 👈 ✅: Success
4/5/21, 7:27:47 PM CDT 👉 com.example.chronical 👈 ℹ️: Info
4/5/21, 7:27:47 PM CDT 👉 com.example.chronical 👈 ⚠️: Warning
4/5/21, 7:27:47 PM CDT 👉 com.example.chronical 👈 ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $100f87918).(unknown context at $100f87964).SomeError error 0.)
}
4/5/21, 7:27:47 PM CDT 👉 com.example.chronical 👈 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $100f87918).(unknown context at $100f87964).SomeError error 0.)
}
```

### OutputFormatter Chronical
```swift
let chrono = Chronical(
    label: "com.example.chronical",
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
4/5/21, 7:29:21 PM CDT [com.example.chronical] ✅: ✅ Success ✅
4/5/21, 7:29:21 PM CDT [com.example.chronical] ℹ️: ℹ️ Info ℹ️
4/5/21, 7:29:21 PM CDT [com.example.chronical] ⚠️: ⚠️ Warning ⚠️
4/5/21, 7:29:21 PM CDT [com.example.chronical] ❗️: ❗️ Error
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
} ❗️
4/5/21, 7:29:21 PM CDT [com.example.chronical] 🚨: 🚨 Fatal
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
} 🚨
```
