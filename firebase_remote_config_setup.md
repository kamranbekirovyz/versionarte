## 🚜 Firebase Remote Config setup guide

To use the `RemoteConfigVersionarteProvider`, you don't need to manually add `firebase_remote_config` to your `pubspec.yaml` file as it's already included as a dependency of `versionarte` package.

However, you need to add a new parameter to your Firebase Remote Config to contain the versioning information for your app. Here are the steps to follow:

### Step 1: open Remote Config tab
If you haven't added any configuration parameters yet, click the `Create configuration` button to add a new parameter. 

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/create-configuration.png)

If you already have some parameters, click the `Add parameter` button to add a new one.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/add-parameter.png)

### Step 2: Upload "versionarte" parameter.

After clicking on either `Create configuration` or `Add parameter`, you will see the following screen. Fill the `Parameter name (key)` field with `versionarte` and choose `Data type` as `JSON`. 

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/name-and-type.png)

Then, expand the `Default value` field and fill it with the following JSON:

```json
{
  "version": "1.0.0",
  "minVersion": "1.0.0",
  "forceUpdate": false,
  "forceUpdateMessage": "Please update your app to continue using it."
}
```

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/add-value.png)

When you click on the `Save` button, the pop-up will be closed. Click on the `Save` button again to confirm the changes.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/save-parameter.png)

### Step 3: Publish the changes

After clicking on the `Save` button click on the `Publish` button to publish the changes.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/publish-changes.png)

### Updating the value

To update the value of the `versionarte` parameter, edit the existing one following the same steps as above.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/edit-value.png)

✅ By following these steps, you should now have the versionarte parameter in your Firebase Remote Config, which you can use to manage your app's versioning information.