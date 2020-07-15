# WordScramble
Another simple game were a user creates viable words from a selected word. This application was made alongside the [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui/20) project 5 tutorial.

## Demo
![gyZXUSU3F8](https://user-images.githubusercontent.com/64978825/87569237-b6bac200-c6be-11ea-9b69-3a17f3bd14f5.gif)


## Project plan and journey
Like previous projects/apps I've created this project is no different in terms of setting out a learning object and plan. The making of this simple app introduced `List`, `onAppear()`, `Bundle`, `fatalError()` and more in addition to strengthening my understanding of `@State`, `Alert` and `Navigationview`.

For example, `List` played an important role in the UI because it allows you combine and mix dynamic rows with static row just like the list present in the bluetooth page in the settings app. Understanding how `Bundle`works will enable me to appreciate how Apple bundles frameworks, files, assets and plug-ins into well defined subcategories which can be accessed using url's similar to url's found in a browser, these url's behave more like a file path rather than information containing a domain name.

`fatalError` is a function provided by Swift that allows an application to catch catastrophic failures earlier on or when an application enters an unknown state or unexpected state. Using `fatalError` in this application meant that whenever the `start.txt` file doesn't load for whatever reason, the app can be killed immediately in a manner that is safe and elegant while providing clear information to the what went wrong.

## Techniques learned
- Using `List`
- Understanding `Bundle`
- Developing a better grasp of `NavigationView`, `@State` and `Alert`

## Credit
Special thanks to Paul at [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui)
