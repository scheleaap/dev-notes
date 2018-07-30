# REST process design principles

Note: The things stated here have been used to implement services in the past. Feedback is appreciated!

## When designing resources

* Distinguish between collection resources and 'normal' resources.
* The relationship between resources determines if they should be nested (association vs. composition)
* Model things, not actions
  * The process of creating a user instead of create a user.
  * The closed flag instead of getClosedFlag.
  * This gives you the possibility to add metadata to a resource, such as information about who made/is making the request or what will/should happen if the process fails.
  * This gives you the possibility to query the state of the process ("how far is it along?")

## Process resources

Distinguish between:

* Long-running (asynchronous) processes and short-running (synchronous) processes
* Complex and simple modifications (whatever "complex" and "simple" means)

### Implementation

<table>
  <tbody>
    <tr>
      <th>Request method</th>
      <th>Response (success)</th>
      <th>Characteristics</th>
      <th>When to use</th>
      <th>When not to use</th>
      <th>Internal example</th>
      <th>External example</th>
    </tr>
    <tr>
      <td>POST</td>
      <td>CREATED</td>
      <td>
        <ul>
        <li>New process resource created</li>
        <li>Usually asynchronous</li>
        <li>Process is queryable</li>
        <li>Processing errors retrievable through resource representation (i.e. GET on resource)</li>
        </ul>
      </td>
      <td>Use for long-running, queryable processes</td>
      <td>Complex to implement, so only use if its distinguishing characteristics are actually needed.</td>
      <td>Report generation, which can take 60 seconds</td>
      <td>Customer enrollment at a bank (perform KYC, perform registration, create debit cards, send letter).</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>OK</td>
      <td>
        <ul>
        <li>No process resource created</li>
        <li>Usually synchronous</li>
        <li>Process not queryable</li>
        <li>Error propagation (only possible if synchronous, otherwise silent failure)</li>
        <li>Response contains link to affected resource</li>
        </ul>
      </td>
      <td>Use for fast processes and actions</td>
      <td>
        <ul>
        <li>Do not use if the process takes a long time</li>
        <li>Do not use if the process history should be available</li>
        </ul>
      </td>
      <td>Importing something</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>OK<br>CREATED</td>
      <td>
        <ul>
        <li>New non-process resource created or existing resource fully updated (i.e. replaced)</li>
        <li>Affects at most one resource</li>
        <li>Synchronous</li>
        <li>Error propagation</li>
        </ul>
      </td>
      <td>Use to set resources to a value<br>Great for setting flags</td>
      <td>Same as POST + OK, plus: Do not use if more than one resource is affected</td>
      <td>Set the cancellation flag for something</td>
      <td>Starring/watching a GitHub repository</td>
    </tr>
    <tr>
      <td>PATCH</td>
      <td>OK</td>
      <td>
        <ul>
        <li>Existing resource partially updated</li>
        <li>Affects at most one resource</li>
        <li>Synchronous</li>
        <li>Error propagation</li>
        </ul>
      </td>
      <td>Use to change a single attribute</td>
      <td>Same as PUT + OK/CREATED</td>
      <td>N/A</td>
      <td>TODO</td>
    </tr>
  </tbody>
</table>

One potential disadvantage of PUT and PATCH requests is that the client is basically describing the desired state of the resource and the server has to deduce the operation (i.e. what it needs to do) from that.

PATCH + OK:
 * Accept PATCH request with a body that accepts one or more fields from the resource

POST + CREATED:
* Store entity in a central database (to allow load balancing and prevent the service from keeping state)
* Collection resource, single resource
* Process has a state: CREATED, PROCESSING, DONE, FAILED
* Add link to resource representation to modified resource if state = DONE


## Implementing search

* Model "a search" instead of the action "perform a search"
* For ds-comonea-deposit and ds-comonea-sbaff trustor, search was implemented as synchronous, queryable process: POSTing a search request to the collection resource CREATED a search resource, which can be queried for the search results. Once created, a search and the results are (mostly) immutable.


## Linking and embedding

* Resources are linked to each other using Hypertext Application Language (HAL)
* Embedding of resources allowed over HAL
  * The embedded resource must be implemented as well
  * The representation of the embedded resource may be a simplified version of the representation


## Literature

* https://www.thoughtworks.com/insights/blog/rest-api-design-resource-modeling
* The GitHub API, example of a simple modification with PATCH (editing an issue): https://developer.github.com/v3/issues/#edit-an-issue
* The GitHub API, example of a complex modification with POST (performing a merge): https://developer.github.com/v3/repos/merging/#perform-a-merge
* The GitHub API, example of a simple resource (starring a repository): https://developer.github.com/v3/activity/starring/#star-a-repository
* The current HAL specification: https://tools.ietf.org/html/draft-kelly-json-hal-08 (work in progress)
* Zalando RESTful API Guidelines: http://zalando.github.io/restful-api-guidelines/
