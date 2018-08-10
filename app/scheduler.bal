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

function main(string... args) {
    //Go pick tasks
    json taskList = listTasks("BallerinaDay");
    //Shedule tasks
    json tasks = taskList.items;
    int noOfTasks = lengthof tasks;
    io:println("Number of tasks: " + noOfTasks);

    int i = 0;
    while (i < noOfTasks) {
        io:println(tasks[i].title);
        string taskTitle = tasks[i].title.toString();
        //Task title coming from google task
        if (!taskTitle.contains("[Scheduled]")) {
            string[] taskAndMin = taskTitle.split("/");
            int minute = check <int>taskAndMin[1];
            string cronExpression = minute + " * * * * ?";
            scheduleAppointment(cronExpression, untaint tasks[i]);
            runtime:sleep(600000);
        }

        i = i + 1;
    }
    //  }
}

function scheduleAppointment(string cronExpression, json googleTask) {
    // Define on trigger function
    (function() returns error?) onTriggerFunction = onTrigger;
    // Define on error function
    (function (error)) onErrorFunction = onError;
    // Schedule appointment.
    io:println("Schedule Appointment");
    app = new task:Appointment(onTriggerFunction, onErrorFunction, untaint cronExpression);
    app.schedule();
    googleTask.title = "Scheduled" + googleTask.title.toString();
    json updatedJson = updateTasks("BallerinaDay", googleTask.id.toString(), googleTask);
    io:println("Scheduled");
}

function onTrigger() returns error? {
    io:println("On trigger");
    send("Reminder! There's a google task that needs to be attended.");
    cancelAppointment();
    return ();
}

// Define the ‘onError’ function for the task timer.
function onError(error e) {
    io:print("[ERROR] failed to execute timed task");
    io:println(e);
}

// Define the function to stop the task.
function cancelAppointment() {
    app.cancel();
}
