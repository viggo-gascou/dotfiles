## Make SQL files 'readable' when using MacOS QuickLook

Add the [below lines](#plist) to the bottom of the Visual Studio Code app's `Info.plist` file just before the last two lines:
```
</dict>
</plist>
```
_The files is located at:_ `/Applications/Visual Studio Code.app/Contents/Info.plist`


<a name="plist"></a>
```
    <array>
      <dict>
          <key>UTTypeConformsTo</key>
          <array>
            <string>public.text</string>
            <string>public.plain-text</string>
          </array>
          <key>UTTypeDescription</key>
          <string>SQL File</string>
          <key>UTTypeIdentifier</key>
          <string>com.microsoft.VSCode</string>
          <key>UTTypeTagSpecification</key>
          <dict>
            <key>public.filename-extension</key>
            <array>
              <string>sql</string>
            </array>
          </dict>
        </dict>
    </array>
```
