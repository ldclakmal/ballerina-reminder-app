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

import ballerina/task;
import ballerina/math;
import ballerina/log;
import ballerina/runtime;
import ballerina/io;
import ballerina/time;

task:Appointment? app;

@final string BALLERINA_DAY = "BallerinaDay";
@final string SCHEDULED = "[⏰] ";

function main(string... args) {
    // Go pick tasks
    json taskList = listTasks(BALLERINA_DAY);
    json tasks = taskList.items;
    // Get the first tasks and shedule an appointment
    json pickedTask = tasks[0];
    log:printInfo("Picked: " + pickedTask.title.toString());
    string taskTitle = pickedTask.title.toString();
    // Task title coming from google task
    if (!taskTitle.contains(SCHEDULED)) {
        if (taskTitle.contains("/")) {
            string[] taskAndMin = taskTitle.split("/");
            if (lengthof taskAndMin > 1) {
                int minute = check <int>taskAndMin[1];
                string cronExpression = minute + " * * * * ?";
                scheduleAppointment(getUntaintedStringIfValid(cronExpression), getUntaintedJsonIfValid(pickedTask));
            }
        }
    }
    //Eliminate program from exiting.
    runtime:sleep(600000);
}

function scheduleAppointment(string cronExpression, json googleTask) {
    // Define on trigger function
    (function() returns error?) onTriggerFunction = onTrigger;
    // Define on error function
    (function (error)) onErrorFunction = onError;
    // Schedule appointment.
    log:printInfo("Scheduling appointment");
    app = new task:Appointment(onTriggerFunction, onErrorFunction, cronExpression);
    app.schedule();
    googleTask.title = SCHEDULED + googleTask.title.toString();
    json updatedJson = updateTasks(BALLERINA_DAY, googleTask.id.toString(), googleTask);
    log:printInfo("Scheduled appointment and mark the task as scheduled");
}

// Trigger the task
function onTrigger() returns error? {
    log:printInfo("Triggered the task");
    send("Reminder! There's a google task that needs to be attended.");
    cancelAppointment();
    return ();
}

// Define the ‘onError’ function for the task timer.
function onError(error e) {
    log:printError("[ERROR] failed to execute timed task", err = e);
}

// Define the function to stop the task.
function cancelAppointment() {
    log:printInfo("Cancelling the appointment");
    app.cancel();
}

function getUntaintedStringIfValid(string input) returns @untainted string {
    // Do some validation to the input string and return the untainted string here
    return untaint input;
}

function getUntaintedJsonIfValid(json input) returns @untainted json {
    // Do some validation to the input string and return the untainted string here
    return untaint input;
}