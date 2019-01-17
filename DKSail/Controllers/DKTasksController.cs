/*
 * Program: DKSail
 * 
 * Name: Dongha Kang
 * Student Number: 8004178
 *        
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DKSail.Models;

namespace DKSail.Controllers
{
    public class DKTasksController : Controller
    {
        private readonly SailContext _context;

        public DKTasksController(SailContext context)
        {
            _context = context;
        }
        /// <summary>
        /// Shows a list of Tasks
        /// </summary>
        /// <returns>a view that contains a list of Tasks</returns>
        // GET: DKTasks
        public async Task<IActionResult> Index()
        {
            return View(await _context.Tasks.ToListAsync());
        }
        /// <summary>
        /// Shows details of a Task when there is an id
        /// </summary>
        /// <param name="id">Task model id</param>
        /// <returns>a view that contails details of the Task with the corresponding id</returns>
        // GET: DKTasks/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var tasks = await _context.Tasks
                .FirstOrDefaultAsync(m => m.TaskId == id);
            if (tasks == null)
            {
                return NotFound();
            }

            return View(tasks);
        }
        /// <summary>
        /// Shows a creat page with blank input fields
        /// </summary>
        /// <returns>a view that contains input fields for Task creation</returns>
        // GET: DKTasks/Create
        public IActionResult Create()
        {
            return View();
        }
        /// <summary>
        /// Saves newly created Task to the list
        /// </summary>
        /// <param name="tasks">a Task object created from user input</param>
        /// <returns>a view that contains the list of Tasks including the newly added</returns>
        // POST: DKTasks/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("TaskId,Name,Description")] Tasks tasks)
        {
            if (ModelState.IsValid)
            {
                _context.Add(tasks);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(tasks);
        }
        /// <summary>
        /// Shows a edit page with input fields filled with corresponding data
        /// </summary>
        /// <param name="id">Task model id</param>
        /// <returns>a view that contains input fields for Task edit</returns>
        // GET: DKTasks/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var tasks = await _context.Tasks.FindAsync(id);
            if (tasks == null)
            {
                return NotFound();
            }
            return View(tasks);
        }
        /// <summary>
        /// Saves newly edited Task to the list
        /// </summary>
        /// <param name="id">Task model id</param>
        /// <param name="tasks">a Task object corresponding to id parameter</param>
        /// <returns>a view that contains the list of Tasks including the newly edited</returns>
        // POST: DKTasks/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("TaskId,Name,Description")] Tasks tasks)
        {
            if (id != tasks.TaskId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(tasks);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TasksExists(tasks.TaskId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(tasks);
        }
        /// <summary>
        /// Shows a delete page
        /// </summary>
        /// <param name="id">Task model id</param>
        /// <returns>a view that contains the Task details with the corresponding id</returns>
        // GET: DKTasks/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var tasks = await _context.Tasks
                .FirstOrDefaultAsync(m => m.TaskId == id);
            if (tasks == null)
            {
                return NotFound();
            }

            return View(tasks);
        }
        /// <summary>
        /// Saves the list excluding the newly deleted item from it
        /// </summary>
        /// <param name="id">Task model id</param>
        /// <returns>a confirmation page</returns>
        // POST: DKTasks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var tasks = await _context.Tasks.FindAsync(id);
            _context.Tasks.Remove(tasks);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
        /// <summary>
        /// a helper method to identify whether a certain Task with this id exists
        /// </summary>
        /// <param name="id">Task model id</param>
        /// <returns>a boolean value of whether the Task exists</returns>
        private bool TasksExists(int id)
        {
            return _context.Tasks.Any(e => e.TaskId == id);
        }
    }
}
