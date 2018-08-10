// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import chanakal/gtasks;

endpoint gtasks:Client gtasksClient {
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: config:getAsString("ACCESS_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET"),
            refreshToken: config:getAsString("REFRESH_TOKEN"),
            refreshUrl: config:getAsString("REFRESH_URL")
        }
    }
};

function listTaskLists() returns json {
    var details = gtasksClient->listTaskLists();
    match details {
        json response => return response;
        gtasks:GTasksError gtasksError => {
            log:printError(gtasksError.message);
            throw gtasksError;
        }
    }
}

function listTasks(string taskListName) returns json {
    var details = gtasksClient->listTasks(taskListName);
    match details {
        json response => return response;
        gtasks:GTasksError gtasksError => {
            log:printError(gtasksError.message);
            throw gtasksError;
        }
    }
}

function updateTasks(string taskListName, string taskId, json task) returns json {
    var details = gtasksClient->updateTask(taskListName, taskId, task);
    match details {
        json response => return response;
        gtasks:GTasksError gtasksError => {
            log:printError(gtasksError.message);
            throw gtasksError;
        }
    }
}
