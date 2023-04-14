## 🚜 Firebase Remote Config setup guide

To use `RemoteConfigVersionarteProvider` there is no need to add `firebase_remote_config` to your `pubspec.yaml` file. This is because `firebase_remote_config` is a dependency of `versionarte` and it will be automatically added to your project.

However, you will need to add a new parameter to your Firebase Remote Config. This parameter will contain the versioning information for your app.

Here are the steps to follow:

### Step 1: open Remote Config tab
If you haven't added any configuration parameter yet, you will see the following screen. Click on the `Create configuration` button to add a new parameter:

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/create-configuration.png)

However, if you already have some parameters, you will see the following screen. Click on the `Add parameter` button to add a new parameter:

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/add-parameter.png)

### Step 2: Upload "versionarte" parameter.

After clicking on either `Create configuration` or `Add parameter`, you will see the following screen. Fill the "Parameter name (key)" field with `versionarte` and choose "Data type" as `JSON`. 

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/name-and-value.png)

Then, click and expand the "Default value" field and fill it with the following JSON and click on the "Save" button:

```json
{
  "version": "1.0.0",
  "minVersion": "1.0.0",
  "forceUpdate": false,
  "forceUpdateMessage": "Please update your app to continue using it."
}
```

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/add-value.png)

When you click on the "Save" button, the popup will close and you will see the following screen. Click on the "Save" button again to confirm the changes.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/save-parameter.png)

### Step 3: Publish the changes

After clicking on the "Save" button, you will see the following screen. Click on the "Publish" button to publish the changes.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/publish-changes.png)

### Updating the value

To update the value of the `versionarte` parameter, you will need to follow the same steps as above, but instead of creating a new parameter, you will need to edit the existing one.

![](https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/remote-config-setup/edit-value.png)