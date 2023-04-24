## 🚜 Firebase Remote Config setup guide

To use the `RemoteConfigVersionarteProvider`, you don't need to add `firebase_remote_config` to your project's `pubspec.yaml` as it's already included as a dependency of `versionarte` package.

However, you need to add a new parameter to your Firebase Remote Config porject to contain the relevant information for your app. Here are the steps to follow:

### Step 1: Open Remote Config dashboard
Go to <a href="https://console.firebase.google.com/">Firebase Console</a> website and select your project. Then, click on the `Remote Config` button.

If you haven't added any configuration parameters yet, click the `Create configuration` button.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/create-configuration.png)

If you already have some parameters, click the `Add parameter` button.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/add-parameter.png)

### Step 2: Upload "versionarte" parameter.

Fill the `Parameter name (key)` field with `versionarte` and choose `Data type` as `JSON`. 

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/name-and-type.png)

Then, expand the `Default value` field and fill it with the `JSON` which derived from <a href="https://github.com/kamranbekirovyz/versionarte#%EF%B8%8F-configuration-json" target="_blank">versionarte configuration JSON</a> in a way that it represents the information for your app.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/add-value.png)

When you click on the `Save` button, the pop-up will be closed. Click on the `Save` button again to confirm the changes.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/save-parameter.png)

### Step 3: Publish the changes

Click `Publish changes` button to publish the changes.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/publish-changes.png)

### Updating the value

To update the value of the `versionarte` parameter, edit the existing one following the same steps as above.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/edit-value.png)

🎉 By following these steps, you should now have the versionarte parameter in your Firebase Remote Config, which you can use to manage your app's versioning and availability.