# Intro

Tech test of the [Soho House reception scheduler](https://github.com/SohoHouse/reception-scheduler)

See [BRIEF.md](/BRIEF.md) for info.


#Plan

We’re starting with Reception shifts but this same system can be applied to any department or role inside the organisation.

For now we have:
- Locations
- Staff / users (name may vary if implemented in another system)
- Shifts
- And ideally a Role

Creating the Role model initially will allow the extension of the system without a difficult migration, but also won’t be huge initial effort and doesn’t try to predict the detail of future requirements.

##What do we need to consider in the long term?

- Access restriction and visibility
- Highlighting uncovered time to managers
- Sick leave & last minute cancellations - Can anyone cancel last minute or should it be management only? What time period is - appropriate? e.g. locked 1 week before shift?
- Holiday - for shift work, this is more a question of payroll but needs to be accounted for
- Busy periods requiring additional staff. This could be a date or day. e.g. 2x staff on Saturdays and New Years Eve.
- Location closed dates
- UX - calendar view
- Download or email of iCal objects, to import into user’s diary
- Integration with payroll system for hours worked
- If salaries are set across the org then roles need to be common across locations


##So what could be the long term approach to this?

Multiple locations, each with departments and positions which need to be filled.
The number of staff required could be configured per position,

A possible model could look like this:

- Role -< Position
- Role.salary = £10/hr
- Location -< Position
- Position.min_staff = 1, max_staff = 3
- Position -< Shift
- User -< Shift
- We could also group Positions inside Departments. This would give us a clean hierarchy for managers to view and control schedules.


To begin with we can start with:

Location -< Positions -< Shifts

User -< Shifts
