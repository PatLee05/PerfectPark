## CSE 340 Group 9 PEER AUDIT
## Auditor: Michelle Vu 		
## Auditee: Leonardo Paredes group 9
## Time: 3:46PM, May 29, 2024
## Location: CSE 2 Undergrad commons
## Devices: Mac laptop & iPhone
## Settings: Default (font size, volume) as well as max font size

## What the app does well:
    The Park Finder app does well with color contrast of the UI. It has a minimalistic color palette that 
    is not overwhelming and ties well with the theme of the app. All the text remains legible as the screen 
    size changes. The spacing between clickable elements and target size is good as well. There is also the 
    inclusion of filters to help refine searching which I find to be a great accessibility feature.

#### Accessibility Issue #1

## Description: 
    Missing Alternative Text for Images
## Testing method: 
    Manual Testing 
## Evidence: 
    Guideline violated: 1.1.1 Non-text Content (Perceivable) (Level A)
## Explanation: 
    When using a screen reader, none of the images accompanying the park details have an alternative text 
    that describes the imagery of the photo. This violates Guideline 1.1.1 because the app does not provide 
    text alternatives for all non-text content to ensure accessibility. These alternatives serve the purpose 
    of making information accessible through various methods, such as visual, auditory, or tactile, which 
    accommodates different user needs. The image is not prompting the screen reader to output a description, 
    which means that people who use screen readers may miss out on the app's content. A person dependent on a 
    screen reader would not be able to process the content. Thus, an alt text description for all images is 
    necessary to give full access to content for all people.

## Severity Rating: 
    4
## Justification: 
    The frequency for this issue is high because every image lacks alternative text. The impact remains high because 
    each park will not have a descriptive text to portray what the snapshot of the area looks like. The persistence is 
    high because a person would not be able to work around the issue, since the image is inaccessible from the screen reader.

## Possible solution: 
    The images do not have alt text because they are from an url attribute in the API used to supply the app with 
    data. A potential solution might be to auto generate a text for the photo by passing it through some alt text
    automating tool, but this could be misleading or general. Another potential solution would be to use a different 
    API that does have an alternative text available for the image or eventually open up the app to crowdsourcing 
    alt text for park images. 

## GIT commit ID:
e2699b5d2eb592df9762a93cdbc43247b34eee00