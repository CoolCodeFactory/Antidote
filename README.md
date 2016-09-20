# Antidote

Antidote Architecture Example


**Folder**

File

Antidote Architecture:
- **App Flow**
  - AppDelegate
  - AppFlowCoordinator
    - **Authentication Flow**
      - FlowCoordinator
      - ViewControllersFactory
      - **Sign In**
        - ViewController
        - ViewManager
        - NetworkService
        - StorageService
      - **Reset password**
        - ViewController
        - ViewManager
        - NetworkService
        - StorageService
    - **Menu Flow**
      - FlowCoordinator
      - ViewControllersFactory
      - **Menu**
        - ViewController
        - ViewManager
        - NetworkService
        - StorageService


Flow Coordinator Types:
- [x] Menu
- [x] Master-Detail
- [x] Page-Based
- [x] Tabbed
- [x] Push into current UINavigationController
- [x] Present modally
- [ ] Present inside container

Questions:
- [ ] Handle container presentation logic and callbacks
- [ ] Childcoordinators as array(stack) OR as stored properties? (how to remove childcoordinator then push into current UINavigationController) 
- [ ] Who must call and setup closeHandler? (flowCoordinator.viewController.navigationItem.leftBarButtonItem OR viewController itself)

## Q&A
Open issue and write all yours questions!
I will answer your questions there :)
