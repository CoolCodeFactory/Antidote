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
  
## Flow Coordinator Types:
- [x] Menu
- [x] Master-Detail
- [x] Page-Based
- [x] Tabbed
- [x] Push into current UINavigationController
- [x] Present modally
- [x] Present inside container
  
## Questions:
- [x] Handle container presentation logic and callbacks? Use public function + callbacks (look at User Container)
- [x] Who must call and setup closeHandler? - current Coordinator setup child's closeHandler, and called own closeHandler.
- [ ] Childcoordinators as array(stack) OR as stored properties? (how to remove childcoordinator then push into current UINavigationController) 
  
## Q&A
Open issue and write all yours questions!  
I will answer your questions there :)
