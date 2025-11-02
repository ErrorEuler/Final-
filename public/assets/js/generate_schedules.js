// Debug logging at the beginning of the script
console.log("=== GENERATE SCHEDULES DEBUG ===");
console.log("Raw data received:", window.jsData);
console.log("Sections data:", window.rawSectionsData);
console.log("Faculty data:", window.faculty);
console.log("Classrooms data:", window.classrooms);
console.log("Curricula data:", window.curricula);
console.log(
  "Curriculum courses for current semester:",
  window.jsData?.curriculumCourses || []
);
console.log("Current semester:", window.currentSemester);
console.log("Department ID:", window.departmentId);

// Initialize data
function initializeScheduleData() {
  window.sectionsData = Array.isArray(window.rawSectionsData)
    ? window.rawSectionsData.map((s, index) => ({
      section_id: s.section_id ?? index + 1,
      section_name: s.section_name ?? "",
      year_level: s.year_level ?? "Unknown",
      academic_year: s.academic_year ?? window.currentAcademicYear,
      current_students: s.current_students ?? 0,
      max_students: s.max_students ?? 30,
      semester: s.semester ?? "",
      is_active: s.is_active ?? 1,
      curriculum_id: s.curriculum_id || null,
    }))
    : [];

  console.log("Processed sections data:", window.sectionsData);

  if (window.sectionsData.length === 0) {
    console.warn("No sections found for the current semester.");
    showValidationToast([
      "No sections found for the current semester. Please ensure sections are added in the database.",
    ]);
  }

  window.curriculumCourses = Array.isArray(window.jsData?.curriculumCourses)
    ? window.jsData.curriculumCourses.map((c, index) => ({
      course_id: c.course_id ?? index + 1,
      course_code: c.course_code ?? "",
      course_name: c.course_name ?? "Unknown",
      year_level: c.curriculum_year ?? "Unknown",
      semester:
        c.curriculum_semester ?? window.currentSemester?.semester_name,
      subject_type: c.subject_type ?? "",
      units: c.units ?? 0,
      lecture_units: c.lecture_units ?? 0,
      lab_units: c.lab_units ?? 0,
      lecture_hours: c.lecture_hours ?? 0,
      lab_hours: c.lab_hours ?? 0,
    }))
    : [];

  console.log("Processed curriculum courses:", window.curriculumCourses);

  if (window.curriculumCourses.length === 0) {
    const coursesList = document.getElementById("courses-list");
    if (coursesList) {
      coursesList.innerHTML =
        '<p class="text-sm text-gray-600">Please select a curriculum to view available courses.</p>';
    }
  }
}

// Helper function to escape HTML
function escapeHtml(unsafe) {
  if (!unsafe) return "";
  return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

// Helper function to get or create toast container
function getOrCreateToastContainer() {
  let toastContainer = document.getElementById("toast-container");
  if (!toastContainer) {
    toastContainer = document.createElement("div");
    toastContainer.id = "toast-container";
    toastContainer.className = "fixed top-4 right-4 z-50 space-y-2";
    document.body.appendChild(toastContainer);
  }
  return toastContainer;
}

// Show validation error toast
function showValidationToast(errors) {
  const toastContainer = getOrCreateToastContainer();

  const toast = document.createElement("div");
  toast.className =
    "bg-red-50 border border-red-200 rounded-lg p-4 shadow-lg max-w-sm w-full transition-opacity duration-300";
  toast.innerHTML = `
    <div class="flex items-start">
      <div class="flex-shrink-0">
        <i class="fas fa-exclamation-circle text-red-500 text-xl"></i>
      </div>
      <div class="ml-3 flex-1">
        <p class="text-sm font-medium text-red-800">Validation Error</p>
        <ul class="list-disc pl-5 text-sm text-red-700 mt-1">
          ${errors.map((error) => `<li>${escapeHtml(error)}</li>`).join("")}
        </ul>
      </div>
      <div class="ml-3 flex-shrink-0">
        <button class="text-red-400 hover:text-red-600" onclick="this.parentElement.parentElement.parentElement.remove()">
          <i class="fas fa-times"></i>
        </button>
      </div>
    </div>
  `;

  toastContainer.appendChild(toast);
  setTimeout(() => {
    toast.classList.add("opacity-0");
    setTimeout(() => toast.remove(), 300);
  }, 5000);
}

// Show completion toast (success or warning)
function showCompletionToast(type, title, messages) {
  const toastContainer = getOrCreateToastContainer();

  const toast = document.createElement("div");
  toast.className = `bg-${type === "success" ? "green" : "yellow"
    }-50 border border-${type === "success" ? "green" : "yellow"
    }-200 rounded-lg p-4 shadow-lg max-w-sm w-full transition-opacity duration-300`;
  toast.innerHTML = `
    <div class="flex items-start">
      <div class="flex-shrink-0">
        <i class="fas ${type === "success"
      ? "fa-check-circle text-green-500"
      : "fa-exclamation-triangle text-yellow-500"
    } text-xl"></i>
      </div>
      <div class="ml-3 flex-1">
        <p class="text-sm font-medium ${type === "success" ? "text-green-800" : "text-yellow-800"
    }">${escapeHtml(title)}</p>
        <ul class="list-disc pl-5 text-sm ${type === "success" ? "text-green-700" : "text-yellow-700"
    } mt-1">
          ${messages.map((msg) => `<li>${escapeHtml(msg)}</li>`).join("")}
        </ul>
      </div>
      <div class="ml-3 flex-shrink-0">
        <button class="${type === "success"
      ? "text-green-400 hover:text-green-600"
      : "text-yellow-400 hover:text-yellow-600"
    }" onclick="this.parentElement.parentElement.parentElement.remove()">
          <i class="fas fa-times"></i>
        </button>
      </div>
    </div>
  `;

  toastContainer.appendChild(toast);
  setTimeout(() => {
    toast.classList.add("opacity-0");
    setTimeout(() => toast.remove(), 300);
  }, 5000);
}

// Highlight invalid form fields
function highlightField(fieldId, hasError) {
  const field = document.getElementById(fieldId);
  if (field) {
    if (hasError) {
      field.classList.add("border-red-500", "ring-2", "ring-red-500");
    } else {
      field.classList.remove("border-red-500", "ring-2", "ring-red-500");
      field.classList.add("border-gray-300");
    }
  }
}

// Clear validation errors
function clearValidationErrors() {
  ["curriculum_id"].forEach((fieldId) => highlightField(fieldId, false));
}

function updateCourses() {
  const curriculumId = document.getElementById("curriculum_id").value;
  const coursesList = document.getElementById("courses-list");

  if (!coursesList) {
    console.error("Courses list element not found");
    return;
  }

  console.log("🔄 updateCourses called with curriculum:", curriculumId);

  if (!curriculumId) {
    coursesList.innerHTML = '<p class="text-sm text-gray-600">Please select a curriculum to view available courses.</p>';
    return;
  }

  coursesList.innerHTML = '<div class="flex items-center text-sm text-gray-600"><i class="fas fa-spinner fa-spin mr-2"></i> Loading courses...</div>';

  // Create form data with ALL required parameters
  const formData = new URLSearchParams();
  formData.append('action', 'get_curriculum_courses');
  formData.append('curriculum_id', curriculumId);
  formData.append('semester_id', window.currentSemester?.semester_id || '6'); // Fallback to current semester
  formData.append('department_id', window.departmentId || '14');
  formData.append('college_id', window.jsData?.collegeId || '7');

  console.log("📤 Sending request with data:", Object.fromEntries(formData));

  fetch("/chair/generate-schedules", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: formData,
  })
    .then(response => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      return response.text();
    })
    .then(text => {
      console.log("📄 Raw response received:", text);
      let data;
      try {
        data = JSON.parse(text);
      } catch (e) {
        console.error("❌ JSON parse error:", e, "Response:", text);
        throw new Error("Invalid JSON response: " + e.message);
      }

      console.log("✅ Fetched courses data:", data);

      // Check if we have courses in the response
      if (data.courses) {
        window.curriculumCourses = data.courses;
      } else if (data.success && data.courses) {
        window.curriculumCourses = data.courses;
      } else {
        window.curriculumCourses = data || [];
      }

      if (window.curriculumCourses.length === 0) {
        coursesList.innerHTML = '<div class="text-sm text-red-600 p-3 bg-red-50 rounded border border-red-200"><i class="fas fa-exclamation-triangle mr-2"></i>No courses found for the selected curriculum.</div>';
      } else {
        // Group courses by year level for better display
        const coursesByYear = {};
        window.curriculumCourses.forEach(course => {
          const year = course.curriculum_year || course.year_level || 'Unknown Year';
          if (!coursesByYear[year]) {
            coursesByYear[year] = [];
          }
          coursesByYear[year].push(course);
        });

        let html = '';
        Object.keys(coursesByYear).sort().forEach(year => {
          html += `
                    <div class="mb-6 p-4 bg-white rounded-lg border border-gray-200">
                        <h4 class="font-semibold text-gray-800 mb-3 text-lg flex items-center">
                            <i class="fas fa-graduation-cap mr-2 text-blue-500"></i>
                            ${escapeHtml(year)}
                        </h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">`;

          coursesByYear[year].forEach(course => {
            const semester = course.curriculum_semester || course.semester || 'All Semesters';
            const units = course.units || 0;
            const subjectType = course.subject_type || 'General Education';

            html += `
                        <div class="p-3 bg-gray-50 rounded border border-gray-100 hover:bg-blue-50 transition-colors">
                            <div class="font-semibold text-gray-800">${escapeHtml(course.course_code)}</div>
                            <div class="text-sm text-gray-600 mb-1">${escapeHtml(course.course_name)}</div>
                            <div class="flex justify-between text-xs text-gray-500">
                                <span>${escapeHtml(semester)}</span>
                                <span>${units} units</span>
                                <span class="capitalize">${escapeHtml(subjectType.toLowerCase())}</span>
                            </div>
                        </div>`;
          });

          html += '</div></div>';
        });

        coursesList.innerHTML = html;

        // Show total count
        const totalCount = document.createElement('div');
        totalCount.className = 'mt-4 p-3 bg-green-50 rounded-lg border border-green-200 text-sm text-green-800';
        totalCount.innerHTML = `
                <div class="flex items-center">
                    <i class="fas fa-check-circle mr-2"></i>
                    <div>
                        <strong>Curriculum Loaded Successfully!</strong><br>
                        Total: ${window.curriculumCourses.length} courses across ${Object.keys(coursesByYear).length} year levels
                    </div>
                </div>
            `;
        coursesList.appendChild(totalCount);

        console.log(`✅ Loaded ${window.curriculumCourses.length} courses for curriculum ${curriculumId}`);
      }
    })
    .catch(error => {
      console.error("❌ Error fetching courses:", error);

      coursesList.innerHTML = `
            <div class="text-sm text-red-600 p-3 bg-red-50 rounded border border-red-200">
                <i class="fas fa-exclamation-circle mr-2"></i>
                Error loading courses: ${escapeHtml(error.message)}
            </div>
        `;
      showValidationToast(["Error loading courses: " + error.message]);
    });
}

// Update schedule completion status banner
function updateScheduleCompletionStatus(data) {
  let statusBanner = document.getElementById("schedule-completion-banner");

  if (statusBanner) {
    statusBanner.remove();
  }

  if (data.unassignedCourses && data.unassignedCourses.length > 0) {
    const navTabs = document.querySelector("nav.flex.space-x-1");
    statusBanner = document.createElement("div");
    statusBanner.id = "schedule-completion-banner";
    statusBanner.className =
      "mb-6 p-4 bg-yellow-50 border-l-4 border-yellow-400 rounded-lg shadow-sm";

    statusBanner.innerHTML = `
      <div class="flex items-start">
        <div class="flex-shrink-0">
          <i class="fas fa-exclamation-triangle text-yellow-600 text-xl"></i>
        </div>
        <div class="ml-3 flex-1">
          <h3 class="text-sm font-semibold text-yellow-800">Schedule Generation Incomplete</h3>
          <div class="mt-2 text-sm text-yellow-700">
            <p class="mb-2">${data.unassignedCourses.length
      } course(s) could not be scheduled automatically:</p>
            <ul class="list-disc list-inside ml-2">
              ${data.unassignedCourses
        .map((c) => `<li>${escapeHtml(c.course_code)}</li>`)
        .join("")}
            </ul>
            <p class="mt-3">
              <strong>Success Rate:</strong> ${data.successRate || "0%"} 
              (${data.totalCourses - data.unassignedCourses.length} of ${data.totalCourses
      } courses scheduled)
            </p>
          </div>
          <div class="mt-3">
            <button onclick="switchTab('manual')" class="text-sm font-medium text-yellow-800 hover:text-yellow-900 underline">
              Go to Manual Edit to fix conflicts →
            </button>
          </div>
        </div>
        <div class="flex-shrink-0 ml-3">
          <button onclick="this.parentElement.parentElement.parentElement.remove()" class="text-yellow-600 hover:text-yellow-800">
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    `;

    if (navTabs && navTabs.parentElement) {
      navTabs.parentElement.insertBefore(statusBanner, navTabs.nextSibling);
    }
  }
}

// FIXED: Main generate schedules function with proper async handling
function generateSchedules() {
  const form = document.getElementById("generate-form");
  if (!form) {
    console.error("Generate form not found");
    return;
  }

  const formData = new FormData(form);
  const curriculumId = formData.get("curriculum_id");

  console.log("generateSchedules called with curriculum:", curriculumId);

  clearValidationErrors();

  // Validation checks
  const validationErrors = [];

  if (!curriculumId) {
    validationErrors.push("Please select a curriculum");
    highlightField("curriculum_id", true);
  }

  if (window.sectionsData.length === 0) {
    validationErrors.push("No sections available for the current semester");
  }

  if (window.curriculumCourses.length === 0) {
    validationErrors.push("No courses available for the selected curriculum");
  }

  if (!window.faculty || window.faculty.length === 0) {
    validationErrors.push("No faculty members available for assignment");
  }

  if (!window.classrooms || window.classrooms.length === 0) {
    validationErrors.push("No classrooms available for assignment");
  }

  if (validationErrors.length > 0) {
    showValidationToast(validationErrors);
    return;
  }

  clearValidationErrors();

  // Show loading overlay
  const loadingOverlay = document.getElementById("loading-overlay");
  if (loadingOverlay) {
    loadingOverlay.classList.remove("hidden");
    console.log("⏳ Loading overlay shown");
  }

  const data = {
    action: "generate_schedule",
    curriculum_id: curriculumId,
    semester_id: formData.get("semester_id"),
    tab: "generate",
  };

  console.log("🚀 Sending data to backend:", data);
  const startTime = performance.now();

  fetch("/chair/generate-schedules", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: new URLSearchParams(data),
  })
    .then((response) => {
      console.log("📡 Response received, status:", response.status);
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return response.text();
    })
    .then((text) => {
      console.log(
        "📄 Raw response received (first 500 chars):",
        text.substring(0, 500)
      );

      let responseData;
      try {
        responseData = JSON.parse(text);
      } catch (e) {
        console.error("❌ Invalid JSON response:", text);
        throw new Error("Invalid response format: " + e.message);
      }

      const fetchTime = performance.now() - startTime;
      console.log(`⏱️ Fetch completed in ${fetchTime.toFixed(2)}ms`);
      console.log("📊 Generation response:", responseData);

      if (responseData.success) {
        // Keep loading visible during updates
        console.log("🔄 Processing response data...");

        // Step 1: Update schedule data
        window.scheduleData = responseData.schedules || [];
        console.log(`✅ Updated ${window.scheduleData.length} schedules`);

        // Step 2: Update UI asynchronously with proper sequencing
        updateUIAfterGeneration(responseData, loadingOverlay, startTime);
      } else {
        hideLoadingAndShowError(
          loadingOverlay,
          responseData.message || "Failed to generate schedules"
        );
      }
    })
    .catch((error) => {
      console.error("❌ Error:", error);
      hideLoadingAndShowError(
        loadingOverlay,
        "Error generating schedules: " + error.message
      );
    });
}

// NEW: Separate function to handle UI updates with proper async sequencing
async function updateUIAfterGeneration(
  responseData,
  loadingOverlay,
  startTime
) {
  try {
    console.log("🎨 Starting UI updates...");

    // Use requestAnimationFrame to ensure DOM is ready
    await new Promise((resolve) => requestAnimationFrame(resolve));

    // Step 1: Update schedule display (this is the heavy operation)
    console.log("📋 Updating schedule display...");
    const displayStartTime = performance.now();

    safeUpdateScheduleDisplay(window.scheduleData);

    const displayTime = performance.now() - displayStartTime;
    console.log(`✅ Display updated in ${displayTime.toFixed(2)}ms`);

    // Step 2: Wait for another frame to ensure render is complete
    await new Promise((resolve) => requestAnimationFrame(resolve));

    // Step 3: Update completion status banner
    console.log("🏁 Updating completion status...");
    updateScheduleCompletionStatus(responseData);

    // Step 4: Update generation results card
    console.log("📊 Updating results card...");
    const generationResults = document.getElementById("generation-results");
    if (generationResults) {
      generationResults.classList.remove("hidden");
      document.getElementById("total-courses").textContent =
        responseData.totalCourses || 0;
      document.getElementById("total-sections").textContent =
        responseData.totalSections || 0;
      document.getElementById("success-rate").textContent =
        responseData.successRate || "100%";
    }

    // Step 5: Wait a bit longer to ensure all DOM updates are painted
    await new Promise((resolve) => setTimeout(resolve, 300));

    // Step 6: NOW hide the loading overlay
    const totalTime = performance.now() - startTime;
    console.log(
      `✨ All updates complete in ${totalTime.toFixed(2)}ms, hiding overlay...`
    );

    if (loadingOverlay) {
      loadingOverlay.classList.add("hidden");
    }

    // Step 7: Show notification AFTER everything is done
    await new Promise((resolve) => setTimeout(resolve, 100));

    if (
      responseData.unassignedCourses &&
      responseData.unassignedCourses.length > 0
    ) {
      showCompletionToast(
        "warning",
        "Schedules generated with some conflicts!",
        [
          `${responseData.unassignedCourses.length} course(s) could not be automatically assigned`,
          "Check for time conflicts or resource limitations",
          "You can manually adjust schedules in the Manual Edit tab",
        ]
      );
    } else {
      showCompletionToast("success", "Schedules generated successfully!", [
        `${responseData.schedules.length} courses scheduled`,
        `${responseData.totalSections} sections assigned`,
        "All courses successfully scheduled without conflicts",
      ]);
    }

    console.log("🎉 Generation process complete!");
  } catch (error) {
    console.error("❌ Error during UI update:", error);
    hideLoadingAndShowError(
      loadingOverlay,
      "Error updating display: " + error.message
    );
  }
}

// Helper function to hide loading and show error
function hideLoadingAndShowError(loadingOverlay, message) {
  if (loadingOverlay) {
    loadingOverlay.classList.add("hidden");
  }
  showValidationToast([message]);
}

// Initialize event listeners
document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM fully loaded, initializing generate_schedules.js");
  console.log("Available curricula:", window.curricula);
  console.log("Current semester:", window.currentSemester);
  console.log("Department ID:", window.departmentId);
  console.log("College ID:", window.jsData?.collegeId);

  initializeScheduleData();

  const curriculumSelect = document.getElementById("curriculum_id");
  if (curriculumSelect) {
    console.log("Curriculum select found, options:", curriculumSelect.options.length);
    curriculumSelect.addEventListener("change", function () {
      console.log("Curriculum changed to:", this.value);
      updateCourses();
    });

    // Trigger initial load if there's a selected curriculum
    if (curriculumSelect.value) {
      console.log("Initial curriculum selected:", curriculumSelect.value);
      updateCourses();
    }
  } else {
    console.error("Curriculum select element not found");
  }

  const generateButton = document.getElementById("generate-btn");
  if (generateButton) {
    generateButton.addEventListener("click", generateSchedules);
    console.log("✅ Generate button event listener attached");
  } else {
    console.error("Generate button not found");
  }
});